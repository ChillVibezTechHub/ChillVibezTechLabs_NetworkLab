# ==============================================================================
# Script: Setup-CVTSite-IIS.ps1
# Description: Installs IIS, creates a self-signed cert, and configures CVTSite
# Run as: Administrator
# ==============================================================================

# --- Configuration Variables ---
$siteName    = "CVTSite"
$sitePath    = "C:\inetpub\$siteName"
$dnsName     = "localhost"          # Hostname/FQDN to match
$httpsPort   = 443

# ------------------------------------------------------------------------------
# 1. Install IIS and Management Tools (OS-aware)
# ------------------------------------------------------------------------------
Write-Host "Checking IIS installation..." -ForegroundColor Cyan

$isServer = (Get-CimInstance -ClassName Win32_OperatingSystem).ProductType -ne 1

if ($isServer) {
    # Windows Server installation
    $installed = (Get-WindowsFeature -Name Web-Server).Installed
    if (-not $installed) {
        Write-Host "Installing IIS and Management Console (Windows Server)..."
        Install-WindowsFeature -Name Web-Server, Web-Mgmt-Console -IncludeManagementTools | Out-Null
    } else {
        Write-Host "IIS is already installed." -ForegroundColor Green
    }
} else {
    # Windows Client (Windows 10 / 11) installation
    $state = (Get-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole).State
    if ($state -ne "Enabled") {
        Write-Host "Installing IIS and Management Console (Windows Client)..."
        Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole, IIS-WebServerManagementTools, IIS-ManagementConsole -All -NoRestart | Out-Null
    } else {
        Write-Host "IIS is already installed." -ForegroundColor Green
    }
}

# Import the IIS administration module
Import-Module WebAdministration -ErrorAction Stop

# ------------------------------------------------------------------------------
# 2. Create the Physical Directory & Landing Page
# ------------------------------------------------------------------------------
if (-not (Test-Path -Path $sitePath)) {
    Write-Host "Creating physical directory: $sitePath"
    New-Item -ItemType Directory -Path $sitePath -Force | Out-Null
}

$htmlContent = @"
<!DOCTYPE html>
<html>
<head><title>$siteName</title></head>
<body>
    <h1>Welcome to $siteName</h1>
    <p>IIS and HTTPS are successfully configured.</p>
</body>
</html>
"@
$htmlContent | Set-Content -Path (Join-Path $sitePath "index.html")

# ------------------------------------------------------------------------------
# 3. Generate Self-Signed Certificate
# ------------------------------------------------------------------------------
Write-Host "Generating self-signed certificate for '$dnsName'..." -ForegroundColor Cyan
$cert = New-SelfSignedCertificate `
    -DnsName $dnsName `
    -CertStoreLocation "Cert:\LocalMachine\My" `
    -FriendlyName "$siteName SSL Cert" `
    -NotAfter (Get-Date).AddYears(1)

Write-Host "Certificate generated with Thumbprint: $($cert.Thumbprint)" -ForegroundColor Green

# ------------------------------------------------------------------------------
# 4. Create or Reconfigure the IIS Website
# ------------------------------------------------------------------------------
if (Get-Website -Name $siteName -ErrorAction SilentlyContinue) {
    Write-Host "Site '$siteName' already exists. Recreating..." -ForegroundColor Yellow
    Remove-Website -Name $siteName
}

Write-Host "Creating website '$siteName' on port 80..."
New-Website -Name $siteName `
    -PhysicalPath $sitePath `
    -Port 80 `
    -Force | Out-Null

# ------------------------------------------------------------------------------
# 5. Add HTTPS Binding & Attach Certificate
# ------------------------------------------------------------------------------
Write-Host "Binding SSL certificate to port $httpsPort..." -ForegroundColor Cyan
New-WebBinding -Name $siteName -Protocol https -Port $httpsPort -IPAddress "*"

# Attach certificate to SSL binding endpoint
$sslBinding = Get-Item -Path "IIS:\SslBindings\0.0.0.0!$httpsPort" -ErrorAction SilentlyContinue
if ($sslBinding) {
    $sslBinding.Delete()
}
Get-Item -Path "Cert:\LocalMachine\My\$($cert.Thumbprint)" | New-Item -Path "IIS:\SslBindings\0.0.0.0!$httpsPort" | Out-Null

Write-Host "`nSetup complete! You can test by browsing to: https://$dnsName" -ForegroundColor Green
