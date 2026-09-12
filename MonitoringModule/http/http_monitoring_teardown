# ==============================================================================
# Script: Teardown-CVTSite-IIS.ps1
# Description: Cleans up CVTSite, removes bindings, deletes certs, files, and optionally IIS
# Run as: Administrator
# ==============================================================================

# --- Configuration Variables (matches setup script) ---
$siteName       = "CVTSite"
$sitePath       = "C:\inetpub\$siteName"
$certFriendly   = "$siteName SSL Cert"
$httpsPort      = 443
$uninstallIIS   = $false    # Set to $true if you want to completely uninstall IIS

# ------------------------------------------------------------------------------
# 1. Remove IIS Website & SSL Binding
# ------------------------------------------------------------------------------
if (Get-Module -ListAvailable -Name WebAdministration) {
    Import-Module WebAdministration -ErrorAction SilentlyContinue

    # Remove SSL Binding from port 443
    Write-Host "Checking for SSL bindings on port $httpsPort..." -ForegroundColor Cyan
    $sslBinding = Get-Item -Path "IIS:\SslBindings\0.0.0.0!$httpsPort" -ErrorAction SilentlyContinue
    if ($sslBinding) {
        Write-Host "Removing SSL binding on 0.0.0.0:$httpsPort..."
        $sslBinding.Delete()
    }

    # Stop and remove the website
    if (Get-Website -Name $siteName -ErrorAction SilentlyContinue) {
        Write-Host "Stopping and removing website '$siteName'..." -ForegroundColor Cyan
        Stop-Website -Name $siteName -ErrorAction SilentlyContinue
        Remove-Website -Name $siteName
        Write-Host "Website '$siteName' removed from IIS." -ForegroundColor Green
    } else {
        Write-Host "Website '$siteName' not found in IIS."
    }

    # Remove the dedicated Application Pool if one was created
    if (Get-Item -Path "IIS:\AppPools\$siteName" -ErrorAction SilentlyContinue) {
        Write-Host "Removing AppPool '$siteName'..."
        Remove-Item -Path "IIS:\AppPools\$siteName" -Recurse
    }
}

# ------------------------------------------------------------------------------
# 2. Remove Self-Signed Certificate
# ------------------------------------------------------------------------------
Write-Host "Searching for certificates matching '$certFriendly'..." -ForegroundColor Cyan
$certs = Get-ChildItem -Path "Cert:\LocalMachine\My" | Where-Object { $_.FriendlyName -eq $certFriendly }

if ($certs) {
    foreach ($cert in $certs) {
        Write-Host "Removing certificate (Thumbprint: $($cert.Thumbprint))..."
        Remove-Item -Path "Cert:\LocalMachine\My\$($cert.Thumbprint)" -Force
    }
    Write-Host "Certificate(s) deleted." -ForegroundColor Green
} else {
    Write-Host "No matching certificate found in Cert:\LocalMachine\My."
}

# ------------------------------------------------------------------------------
# 3. Delete Physical Files & Directory
# ------------------------------------------------------------------------------
if (Test-Path -Path $sitePath) {
    Write-Host "Removing physical directory: $sitePath..." -ForegroundColor Cyan
    Remove-Item -Path $sitePath -Recurse -Force
    Write-Host "Directory deleted." -ForegroundColor Green
} else {
    Write-Host "Directory $sitePath does not exist."
}

# ------------------------------------------------------------------------------
# 4. (Optional) Uninstall IIS Role / Features
# ------------------------------------------------------------------------------
if ($uninstallIIS) {
    Write-Host "`nUninstalling IIS..." -ForegroundColor Yellow
    $isServer = (Get-CimInstance -ClassName Win32_OperatingSystem).ProductType -ne 1

    if ($isServer) {
        Uninstall-WindowsFeature -Name Web-Server, Web-Mgmt-Console -IncludeManagementTools | Out-Null
    } else {
        Disable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole, IIS-WebServerManagementTools, IIS-ManagementConsole -NoRestart | Out-Null
    }
    Write-Host "IIS uninstalled successfully." -ForegroundColor Green
} else {
    Write-Host "`nIIS features retained (Set `$uninstallIIS = `$true in the script if you wish to remove IIS)." -ForegroundColor DarkGray
}

Write-Host "`nTeardown complete!" -ForegroundColor Green
