$ErrorActionPreference = 'Stop'

if (-not (Test-Path ".\apache-maven-3.9.6\bin\mvn.cmd")) {
    Write-Host "Downloading Maven..."
    Invoke-WebRequest -Uri "https://archive.apache.org/dist/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip" -OutFile "maven.zip"
    Write-Host "Extracting Maven..."
    Expand-Archive -Path "maven.zip" -DestinationPath . -Force
    Remove-Item "maven.zip"
}

Write-Host "Starting Jetty Server..."
.\apache-maven-3.9.6\bin\mvn.cmd clean jetty:run
