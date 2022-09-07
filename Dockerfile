# escape=`
FROM mcr.microsoft.com/dotnet/sdk:6.0-windowsservercore-ltsc2019
WORKDIR C:\bin

COPY bin .
RUN pwsh -File C:\bin\setup.ps1
