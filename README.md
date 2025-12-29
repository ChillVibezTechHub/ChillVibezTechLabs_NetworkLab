# About this Lab
### Requirements: 
Windows 10/11 Pro or Enterprise
32MB Ram
64bit Processor supporting SLAT

### Notes:
* Use the commands in this lab by copying and pasting them into the powershell terminal.

* Enter Administrator mode command line by pressing Windows Key + X Key, then select "Terminal Admin". 

# Get Started
1. Order Lab here:
[https://Chillvibeztech.com](https://chillvibeztech.com/)

2. Sign up for Windows Trial and Download the ISO here:
[WindowsServerTrial](https://info.microsoft.com/ww-landing-evaluate-windows-server-2025.html?lcid=en-us&culture=en-us&country=us)

3. Install Git after Downloading here:
[Download Git Windows/x64 Setup](https://git-scm.com/install/windows)

# Setup Host Machine (Lab PC)  

COPY HYPER V COMMAND

	Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

COPY RESTART COMMAND

	SHUTDOWN /R /T 00

# Setup Lab Environment 

COPY CLONE ROUTING LAB COMMAND
	
	git clone https://github.com/ChillVibezTechHub/ChillVibezTechLabs_NetworkLab.git

COPY ENABLE SIGNED SCRIPTS COMMAND
	
	Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

COPY SETUP PATH COMMAND
	
	$SetupPath = "ChillVibezTechLabs_NetworkLab\RoutingLab_Setup.ps1"

COPY LOCAL PATH COMMAND

	$localpath = Get-Location | Select-Object -ExpandProperty "Path"

COPY EXECUTE SETUP COMMAND	

	powershell $localpath\$SetupPath

# Install Windows Server on each VM
For each lab Virtual Machine follow the Windows installation guide here:
https://youtube.com/shorts/mRFlOS7TIfg

# Build the Routing Lab
Follow the steps in the content video here:
https://youtu.be/dukyOlMFK0E


Contact
jhames@chillvibeztech.com
