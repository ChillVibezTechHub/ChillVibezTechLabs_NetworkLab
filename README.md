# About this Lab
Get hands on networking experience by completing this lab!
Follow the 3 steps below to get started!

## Requirements: 
Windows 10/11 Pro or Enterprise
32MB Ram
64bit Processor supporting SLAT

# Get Started

## 1. Download Windows Server
Sign up for Windows trial and download the ISO here:
[WindowsServerTrial](https://info.microsoft.com/ww-landing-evaluate-windows-server-2025.html?lcid=en-us&culture=en-us&country=us)

## 2. Install Github
Install Git after downloading here:
[Download Git Windows/x64 Setup](https://git-scm.com/install/windows)

## 3. Setup Host Machine
### Setup Host Machine Part 1  
### Notes:
* Use the commands in this lab by copying and pasting them into the powershell terminal.

* Enter Administrator mode command line by pressing Windows Key + X Key, then select "Terminal Admin". 

COPY HYPER V COMMAND

	Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

COPY RESTART COMMAND

	SHUTDOWN /R /T 00

### Setup Host Machine Part 2

COPY CLONE ROUTING LAB COMMAND
	
	git clone https://github.com/ChillVibezTechHub/ChillVibezTechLabs_NetworkLab.git

COPY ENABLE SIGNED SCRIPTS COMMAND
	
	Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
	
### Setup Host Machine Part 3

COPY SETUP PATH COMMAND
	
	$SetupPath = "ChillVibezTechLabs_NetworkLab\RoutingLab_Setup.ps1"

COPY LOCAL PATH COMMAND

	$localpath = Get-Location | Select-Object -ExpandProperty "Path"

COPY EXECUTE SETUP COMMAND	

	powershell $localpath\$SetupPath

## 4. Install Windows Server on each VM
For each Virtual Machine
 * Start the VM
 * Restart the VM
 * Follow the Windows installation guide here:
	https://youtube.com/shorts/mRFlOS7TIfg

## 5. Build the Lab
Follow the instructions in the Email after purchase
Order lab instructions here: [https://Chillvibeztech.com](https://chillvibeztech.com/)

## Teardown Host Setup When Finished
COPY TEARDOWN PATH COMMAND
	
	$TeardownPath = "ChillVibezTechLabs_NetworkLab\RoutingLab_Teardown.ps1"

COPY LOCAL PATH COMMAND

	$localpath = Get-Location | Select-Object -ExpandProperty "Path"
	
COPY EXECUTE SETUP COMMAND	

	powershell $localpath\$TeardownPath

## Contact Us
For questions, support, or feedback. Send an Email here:
contactchillvibez@chillvibeztech.com
