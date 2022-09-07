$ErrorActionPreference = 'Stop'

if (Test-Path bin) {
    Remove-Item bin -Recurse -Force
}
New-Item -ItemType Directory bin > $null

dotnet build .\WorkerServiceStudy\WindowsServiceStudy\WindowsServiceStudy.csproj -c Release -o bin\ServiceBase
dotnet publish .\WorkerServiceStudy\WorkerServiceStudy\WorkerServiceStudy.csproj -f net7.0 -c Release -r win10-x64 /p:PublishSingleFile=true --no-self-contained -o bin\BackgroundService-net7.0
dotnet publish .\WorkerServiceStudy\WorkerServiceStudy\WorkerServiceStudy.csproj -f net47 -c Release -r win10-x64 -o bin\BackgroundService-net47
dotnet publish .\WorkerServiceStudy\WorkerServiceWithSC\WorkerServiceWithSC.csproj -c Release -r win10-x64 /p:PublishSingleFile=true --no-self-contained -o bin\WorkerServiceWithSC

Copy-Item -Path .\setup.ps1 -Destination .\bin

docker build -t background-service-test:latest .
docker run -it --rm background-service-test:latest pwsh