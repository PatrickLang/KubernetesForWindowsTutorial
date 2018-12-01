# This isn't signed, must be run with powershell.exe -ExecutionPolicy bypass ...
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install -y git kubernetes-cli azure-cli vscode
# For more info on VS install components see https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-community?view=vs-2017#aspnet-and-web-development
choco install -y visualstudio2017community --package-parameters "--locale en-US --add Microsoft.VisualStudio.Workload.NetWeb --add Microsoft.Net.Component.4.7.2.SDK --includeRecommended"

# TODO: fix path

mkdir c:\repos
cd c:\repos

git clone https://github.com/PatrickLang/mssql-docker
git clone https://github.com/PatrickLang/Visitors

cd mssql-docker\windows\mssql-server-windows-express
git checkout windowsserver2019
docker build -t mssql-server-windows-express .