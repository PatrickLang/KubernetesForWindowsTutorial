# This isn't signed, must be run with powershell.exe -ExecutionPolicy bypass ...
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install -y git kubernetes-cli azure-cli vscode
choco install -y visualstudio2017community --package-parameters "--locale en-US --add Microsoft.VisualStudio.Workload.NetWeb --includeRecommended"

# TODO: fix path

mkdir c:\repos
cd c:\repos

git clone https://github.com/PatrickLang/mssql-docker

cd mssql-docker\windows\mssql-server-windows-express
git checkout windowsserver2019
docker build -t mssql-server-windows-express .