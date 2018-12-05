Disable-ScheduledTask -TaskName "\PowerShell\Finish Installing Stuff (run once)"
# Pull images

# Install Ubuntu, run install-stuff-in-wsl.sh
$tmpDir = New-Item -ItemType Directory -Path (Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName()))
Push-Location $tmpDir
curl.exe -L -o ubuntu-1804.appx https://aka.ms/wsl-ubuntu-1804
Rename-Item ubuntu-1804.appx Ubuntu.zip
Expand-Archive Ubuntu.zip ~/Ubuntu
Pop-Location
Remove-Item -Recurse $tmpDir

# Ubuntu\ubuntu1804.exe