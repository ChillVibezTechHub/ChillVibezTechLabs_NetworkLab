#Enable HyperV

#Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All


# Define variables
$vhdPath = "C:\VM"
$downloadsFolder = $Env:USERPROFILE+"\Downloads"
$isoFile = Get-ChildItem -Path $downloadsFolder -Filter "*SERVER_EVAL_x64FRE_en-us.iso" | Select-Object -ExpandProperty "Name"
[String]$isoPath = $Env:USERPROFILE+"\Downloads\$isoFile"
$memoryStartupBytes = 4GB
$hdSize = 90GB
$networkSwitchName = "Default Switch"


$names = @("Red","Green","Blue","Router")



# Create virtual machine
foreach($name in $names){

$path = $vhdPath+"\$name\$name"+".vhdx"

New-VM -Name $name -MemoryStartupBytes $memoryStartupBytes -Generation 2

# Add virtual hard disk
New-VHD -Path $path -SizeBytes $hdSize -Dynamic
Add-VMHardDiskDrive -VMName $name -Path $path -ControllerLocation 1

# Add network adapter
Add-VMNetworkAdapter -VMName $name -SwitchName $networkSwitchName

# Add ISO for operating system installation
Add-VMDvdDrive -VMName $name -Path $isoPath -ControllerLocation 0
Write-Output $isoPath
$old_boot_order = Get-VMFirmware -VMName $name | Select-Object -ExpandProperty BootOrder
$new_boot_order = $old_boot_order | Where-Object { $_.BootType -ne "Network" }
Set-VMFirmware -VMName $name -BootOrder $new_boot_order



# Start the virtual machine
#Start-VM -Name $vmName$name

}

# SIG # Begin signature block
# MIIFfwYJKoZIhvcNAQcCoIIFcDCCBWwCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU7l9z9vReW7jwizyFHmrtO1CR
# CoygggMUMIIDEDCCAfigAwIBAgIQGgxxhSY8Z7ZFVSS1V899ODANBgkqhkiG9w0B
# AQUFADAgMR4wHAYDVQQDDBVDaGlsbCBWaWJlcyBUZWNoIExhYnMwHhcNMjUwNTMx
# MTUzNTA1WhcNMjYwNTMxMTU1NTA1WjAgMR4wHAYDVQQDDBVDaGlsbCBWaWJlcyBU
# ZWNoIExhYnMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDYmOfM43EX
# ggrVcWcNrEckunO0033WLsJD85AhOUgPltRGsicHBx9ebFVii07oGpAqmIeWPdrs
# 8Kxc+CsIwaXa2Mt6Mm+zcdYgTOee0zSmzXe1L1fFaBlihUK6oob5AZ7GsFU6fgPu
# MBYbtUHrcjyfUTE/4aR2fM0iOHFbDlI+BSecUiVAm7LHkDWh3QwyFzI0uz1FRzaV
# wHIWz5887aVYwNWeLNUToAjMZWWjoOxZ+7FCZ9NpVpVTlsiwbEkrgauSM3ndvhtI
# kGf0uWS4dfk6Q3J2dy9Ygryq1b4TnrGJ+0EGI1UHdS5KMJyrgFKc8sFXdeCsDWj5
# eYEq59U+1n9tAgMBAAGjRjBEMA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggr
# BgEFBQcDAzAdBgNVHQ4EFgQUyGSkoKHGXemOO/R1Q3xMQkO0HqgwDQYJKoZIhvcN
# AQEFBQADggEBAFvx8k8jXbSe0uSiAPP3waqu418iZhRPPaKTz9Ublt0TT9hYykw5
# LbukUj7beCtkhP+l04TKzTrrmdLjYTAelhX0tLwEDRPCi8GLkjuUkOIyWFHfImOV
# P3hw1hif3j1Bx98sXdsXitDLaQY+P7vUOTWqucvg673e1T12f6h9SW1DS1J5B3Jk
# VUDQOebd5G8/x//V/hlJkjFNEw7QRmD+TS48W41JmznL35zucNPDlSvKrCkItaez
# lmbh6PMlieEwZ84rQBTeZ4cJyBQHsfrmS3cAih93kICvWxgZI/ovwS4b1qTzsXlE
# yEBiUmG/Kdhv4ElaN2xTUMbHlYR3pCybUu0xggHVMIIB0QIBATA0MCAxHjAcBgNV
# BAMMFUNoaWxsIFZpYmVzIFRlY2ggTGFicwIQGgxxhSY8Z7ZFVSS1V899ODAJBgUr
# DgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMx
# DAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkq
# hkiG9w0BCQQxFgQUG0JLagKf40F8Z9XdFpJfWXeR62cwDQYJKoZIhvcNAQEBBQAE
# ggEAtALNO3r7qfBTW8aqSrsP2fqKpecTLfUA1jDXA78iBxS8nUuQYadAVXtX/0Se
# QF8YX64DLzFDSGMcL5xgxxw6w/uQpcg4hNVxisxKe3DGbV6fVMNtsaHcwAa5F0UK
# iOY3W3NJxv5Ll6twfdpPS95aI/IH5HWhWZDkxtW+TvFYl6CHrMOOdG+eB9UIYJy6
# P21MRd6j4o6WRsc+JQLz5aQSXcVk/ha770rosBBjP2iB8/mphLhFC8VG35G/v/Fc
# RDiBreGLQfrYOjlAH1wd+E1Pe2ratcjJ3LzX5fsHOWuZpalhUn9NGNg7pZU33Tue
# xliv2XK6H6IvVQtqzUktMCKF4w==
# SIG # End signature block
