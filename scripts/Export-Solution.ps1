# Export-Solution.ps1
# Script to export Dataverse solutions

param(
    [Parameter(Mandatory=$true)]
    [string]$SolutionName,
    
    [Parameter(Mandatory=$false)]
    [string]$EnvironmentName = "Default",
    
    [Parameter(Mandatory=$false)]
    [string]$ExportPath = "./solutions",
    
    [Parameter(Mandatory=$false)]
    [switch]$Managed = $false,
    
    [Parameter(Mandatory=$false)]
    [switch]$IncludeVersionInName = $true
)

Write-Host "Exporting Dataverse solution..." -ForegroundColor Green
Write-Host "Solution Name: $SolutionName" -ForegroundColor Yellow
Write-Host "Environment: $EnvironmentName" -ForegroundColor Yellow
Write-Host "Export Path: $ExportPath" -ForegroundColor Yellow

# Create export directory if it doesn't exist
if (!(Test-Path $ExportPath)) {
    New-Item -ItemType Directory -Path $ExportPath -Force
    Write-Host "Created export directory: $ExportPath" -ForegroundColor Cyan
}

try {
    # Set the active environment
    pac auth select --name $EnvironmentName
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to select environment: $EnvironmentName" -ForegroundColor Red
        exit 1
    }
    
    # Get solution version
    $version = ""
    if ($IncludeVersionInName) {
        $solutionInfo = pac solution list --query "[?name=='$SolutionName']" --output json | ConvertFrom-Json
        if ($solutionInfo) {
            $version = $solutionInfo.version
        }
    }
    
    # Build export filename
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $managedSuffix = if ($Managed) { "-managed" } else { "-unmanaged" }
    $versionSuffix = if ($version) { "-v$version" } else { "" }
    $exportFileName = "$SolutionName$versionSuffix$managedSuffix-$timestamp.zip"
    $fullExportPath = Join-Path $ExportPath $exportFileName
    
    # Export the solution
    $exportType = if ($Managed) { "managed" } else { "unmanaged" }
    pac solution export --path $fullExportPath --name $SolutionName --managed $Managed
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Successfully exported solution to: $fullExportPath" -ForegroundColor Green
        
        # Get file size
        $fileSize = (Get-Item $fullExportPath).Length
        $fileSizeMB = [math]::Round($fileSize / 1MB, 2)
        Write-Host "File size: $fileSizeMB MB" -ForegroundColor Cyan
    } else {
        Write-Host "Failed to export solution." -ForegroundColor Red
        exit 1
    }
}
catch {
    Write-Host "Error exporting solution: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
