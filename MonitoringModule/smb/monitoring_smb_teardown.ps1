# Run as Administrator

$shareName = "CVTShare"
$folderPath = "C:\CVTShare"

# 1. Stop sharing the folder if it currently exists
if (Get-SmbShare -Name $shareName -ErrorAction SilentlyContinue) {
    Remove-SmbShare -Name $shareName -Force
}

# 2. Remove the directory and all contents inside it recursively
if (Test-Path -Path $folderPath) {
    Remove-Item -Path $folderPath -Recurse -Force
}
