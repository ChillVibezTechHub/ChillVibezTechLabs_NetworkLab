$wiresharkfilepath = Get-Childitem –Path $Env:USERPROFILE\Downloads\Wireshark*

Enable-VMIntegrationService -Name "Guest Service Interface" -VMName "Router"

Copy-VMFile -Name "Router" -SourcePath $wiresharkfilepath -DestinationPath "C:\LabFiles\WiresharkInstall.exe" -CreateFullPath -FileSource Host

