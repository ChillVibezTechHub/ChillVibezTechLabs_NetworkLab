#About this Lab
This lab uses Powershell commands in Administrator mode.

# Get Started
Order Lab here:
[https://Chillvibeztech.com](https://chillvibeztech.com/)


Sign up for Windows Trial and Download the ISO here:
[WindowsServerTrial](https://info.microsoft.com/ww-landing-evaluate-windows-server-2025.html?lcid=en-us&culture=en-us&country=us)

Install Git

# Setup Host Machine (Lab PC)  

HYPER V COMMAND

	Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

RESTART COMMAND

	SHUTDOWN /R /T 00

# Setup Lab Environment 

CLONE ROUTING LAB COMMAND
	
	git clone https://github.com/ChillVibezTechHub/ChillVibezTechLabs_NetworkLab.git

ENABLE SIGNED SCRIPTS COMMAND
	
	Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

COPY SETUP PATH COMMAND
	
	$SetupPath = "ChillVibezTechLabs_NetworkLab\RoutingLab_Setup.ps1"

COPY LOCAL PATH COMMAND

	$localpath = Get-Location | Select-Object -ExpandProperty "Path"

EXECUTE SETUP COMMAND	

	powershell $localpath\$SetupPath

For each lab Virtual Machine follow the Windows installation guide here:
https://youtube.com/shorts/mRFlOS7TIfg

# Build the Routing Lab
Follow the steps in the content video here:
https://youtu.be/dukyOlMFK0E


Contact
jhames@chillvibeztech.com
