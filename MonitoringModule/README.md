
# About this Module
### Requirements: 
The Completed NetworkLab Environment is a prerequesite

### Notes:
* Use the commands in this lab by copying and pasting them into the powershell terminal.

* Enter Administrator mode command line by pressing Windows Key + X Key, then select "Terminal Admin".

# Get Started
1. Order Module here:
[https://Chillvibeztech.com](https://chillvibeztech.com/)

# Download Wireshark Here
https://www.wireshark.org/

# Setup Lab Environment

CLONE MONITORING MODULE REPO COMMAND

	git clone https://github.com/ChillVibezTechHub/ChillVibezTechLabs_NetworkLab.git

COPY SETUP PATH COMMAND
	
	$SetupPath = "ChillVibezTechLabs_NetworkLab\MonitoringModule\MonitoringModule_Setup.ps1"

COPY LOCAL PATH COMMAND

	$localpath = Get-Location | Select-Object -ExpandProperty "Path"

COPY EXECUTE SETUP COMMAND	

	powershell $localpath\$SetupPath

# Complete The Youtube Video!


