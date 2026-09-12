# Run as Administrator

$sharePath = "C:\CVTShare"
$shareName = "CVTShare"
$fileName  = "hello.txt"

# 1. Create the directory if it does not already exist
if (-not (Test-Path -Path $sharePath)) {
    New-Item -Path $sharePath -ItemType Directory -Force | Out-Null
}

# 2. Change directory
Set-Location -Path $sharePath

# 3. Append text to hello.txt
Add-Content -Path (Join-Path $sharePath $fileName) -Value "tezzt"

# 4. Create the SMB share with Full permissions for Everyone
# Option A: Native PowerShell cmdlet (Recommended)
if (-not (Get-SmbShare -Name $shareName -ErrorAction SilentlyContinue)) {
    New-SmbShare -Name $shareName -Path $sharePath -FullAccess "Everyone"
}

# Option B: Direct equivalent using legacy 'net share'
# net share "$shareName=$sharePath" /grant:Everyone,full
