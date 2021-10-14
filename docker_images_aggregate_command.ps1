#!/usr/bin/env pwsh
param ($F)
Write-Host "Run script through all filtered docker images." -ForegroundColor blue -BackgroundColor white
$filter = if($F) { $F; } else { Read-Host "Enter images filter to do action"; }
Write-Host "Applying filter: $filter" -ForegroundColor blue -BackgroundColor green

$imagesTable = docker images --filter=reference=$filter --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedAt}}\t{{.Size}}"
$command = foreach($image in $imagesTable) {
    Write-Host $image -ForegroundColor blue -BackgroundColor white
}
Write-Host $command -ForegroundColor blue -BackgroundColor green
$proceedWithPush = $(Write-Host "CONTINUE? (y=yes)" -ForegroundColor white -BackgroundColor red -NoNewLine; Read-Host)
if($proceedWithPush -eq 'y' -or $proceedWithPush -eq 'Y')
{
$images = docker images --filter=reference=$filter --format "{{.Repository}}:{{.Tag}}"
  foreach($image in $images) {
    Write-Host "processing $image" -ForegroundColor blue -BackgroundColor green
    try {
      #add logic here
    }
    catch {
      Write-Host "Error with image - $_" -ForegroundColor black -BackgroundColor red
      PAUSE
    }
  }
}
else
{
  Write-Host "Shutting down." -ForegroundColor white -BackgroundColor red
}
