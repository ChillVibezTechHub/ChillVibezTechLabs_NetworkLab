#Enable HyperV

#Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All


# Define variables
$vhdPath = "C:\VM"
$isoPath = $Env:USERPROFILE+"\Downloads\*SERVER_EVAL_x64FRE_en-us.iso"
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
Add-VMDvdDrive -VMName $name -Path $isoPath  -ControllerLocation 0

$old_boot_order = Get-VMFirmware -VMName $name | Select-Object -ExpandProperty BootOrder
$new_boot_order = $old_boot_order | Where-Object { $_.BootType -ne "Network" }
Set-VMFirmware -VMName $name -BootOrder $new_boot_order



# Start the virtual machine
#Start-VM -Name $vmName$name

}
