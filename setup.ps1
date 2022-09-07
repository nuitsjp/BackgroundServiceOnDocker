$ErrorActionPreference = 'Stop'

New-Service -Name Test-ServiceBase -BinaryPathName C:\bin\ServiceBase\WindowsServiceStudy.exe
New-Service -Name Test-BackgroundService-net47 -BinaryPathName C:\bin\BackgroundService-net47\WorkerServiceStudy.exe
New-Service -Name Test-BackgroundService-net7.0 -BinaryPathName C:\bin\BackgroundService-net7.0\WorkerServiceStudy.exe
New-Service -Name Test-WorkerServiceWithSC -BinaryPathName C:\bin\WorkerServiceWithSC\WorkerServiceWithSC.exe