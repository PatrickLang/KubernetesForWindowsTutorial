# This isn't signed, must be run with powershell.exe -ExecutionPolicy bypass ...

# Disable Server Manager autostart
Set-ItemProperty HKCU:\Software\Microsoft\ServerManager -Name DoNotOpenServerManagerAtLogon -Value 1

# Set up Chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# The "Windows Server 2019 with Containers" VM on Azure already has Docker installed, and a few images pre-pulled
if ((get-command docker.exe -ErrorAction Ignore) -ne $null) {
    Write-Host "Docker already installed, skipping"
} else {
    Install-Module DockerMsftProvider -Force
    Install-Package Docker -ProviderName DockerMsftProvider -Force
    choco install -y docker-compose
}

Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName Microsoft-Windows-Subsystem-Linux

choco install -y git kubernetes-cli azure-cli vscode kubernetes-helm draft firefox putty
# For more info on VS install components see https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-community?view=vs-2017#aspnet-and-web-development
choco install -y visualstudio2017community --package-parameters "--locale en-US --add Microsoft.VisualStudio.Workload.NetWeb --add Microsoft.Net.Component.4.7.2.SDK --add Microsoft.Net.ComponentGroup.4.7.2.DeveloperTools --includeRecommended"

# Download Ubuntu
$tmpDir = New-Item -ItemType Directory -Path (Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName()))
Push-Location $tmpDir
curl.exe -L -o ubuntu-1804.appx https://aka.ms/wsl-ubuntu-1804
Rename-Item ubuntu-1804.appx Ubuntu.zip
Expand-Archive Ubuntu.zip ~/Ubuntu
Pop-Location
Remove-Item -Recurse $tmpDir


# Pin useful things to taskbar
curl.exe -o ~/modified-taskbar.xml -L https://raw.githubusercontent.com/PatrickLang/KubernetesForWindowsTutorial/master/LabVm/modified-taskbar.xml
Import-StartLayout -LayoutPath .\modified-start.xml -MountPath c:\
get-process explorer | stop-process ; explorer.exe

# TODO: fix path so git works

mkdir c:\repos
#cd c:\repos

#git clone https://github.com/PatrickLang/mssql-docker
#git clone https://github.com/PatrickLang/Visitors

#cd mssql-docker\windows\mssql-server-windows-express
#git checkout windowsserver2019
#docker build -t mssql-server-windows-express .

# TODO: This is still not working. The post-reboot script needs to run as the user to finish setting up WSL
curl.exe -L https://raw.githubusercontent.com/PatrickLang/KubernetesForWindowsTutorial/master/LabVm/postreboot.ps1 -o c:\postreboot.ps1
#$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-command C:\postreboot.ps1'
#$trigger = New-ScheduledTaskTrigger -AtStartup
#Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "\PowerShell\Finish Installing Stuff (run once)" -Description "Finish pulling images and other things that need to be done once after installing features"
schtasks /create /TN RebootToContinue /RU SYSTEM /TR "shutdown.exe /r /t 0 /d 2:17" /SC ONCE /ST $(([System.DateTime]::Now + [timespan]::FromMinutes(1)).ToString("HH:mm")) /V1 /Z