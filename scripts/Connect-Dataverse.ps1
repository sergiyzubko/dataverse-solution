# Connect-Dataverse.ps1
# Script to connect to Dataverse environments

param(
    [Parameter(Mandatory=$true)]
    [string]$EnvironmentUrl,
    
    [Parameter(Mandatory=$false)]
    [string]$EnvironmentName = "Default"
)

Write-Host "Connecting to Dataverse environment..." -ForegroundColor Green
Write-Host "Environment URL: $EnvironmentUrl" -ForegroundColor Yellow
Write-Host "Environment Name: $EnvironmentName" -ForegroundColor Yellow

try {
    # Create authentication profile
    pac auth create --name $EnvironmentName --url $EnvironmentUrl
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Successfully connected to Dataverse environment!" -ForegroundColor Green
        
        # List available environments
        Write-Host "`nAvailable environments:" -ForegroundColor Cyan
        pac auth list
    } else {
        Write-Host "Failed to connect to Dataverse environment." -ForegroundColor Red
        exit 1
    }
}
catch {
    Write-Host "Error connecting to Dataverse: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
