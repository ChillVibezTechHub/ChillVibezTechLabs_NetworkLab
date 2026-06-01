
# About this Module
Get hands on networking monitoring experience by completing this lab.
Follow the 3 steps below to get started!

## 0. Requirements: 
The Completed NetworkLab Environment is a prerequesite. Find it here:
[ChillVibezTech_NetworkLab](https://github.com/ChillVibezTechHub/ChillVibezTechLabs_NetworkLab)

## 1. Get Started
Order Module here:
[https://Chillvibeztech.com](https://chillvibeztech.com/)

## 2. Download Wireshark 
Download Wireshark from here:
https://www.wireshark.org/

## 3. Setup Lab Environment

### Notes:
* Use the commands in this lab by copying and pasting them into the powershell terminal.

* Enter Administrator mode command line by pressing Windows Key + X Key, then select "Terminal Admin".


CLONE MONITORING MODULE REPO COMMAND

	git clone https://github.com/ChillVibezTechHub/ChillVibezTechLabs_NetworkLab.git

COPY SETUP PATH COMMAND
	
	$SetupPath = "ChillVibezTechLabs_NetworkLab\MonitoringModule\MonitoringModule_Setup.ps1"

COPY LOCAL PATH COMMAND

	$localpath = Get-Location | Select-Object -ExpandProperty "Path"

COPY EXECUTE SETUP COMMAND	

	powershell $localpath\$SetupPath

# Complete The Youtube Video!


