$resource = Get-AzResource
Clear-Host
$startdate = Get-Date
while (($resource | Measure-Object).Count -ne 0) {
    $resource = Get-AzResource
    Clear-Host
    Write-Host "Script stated: " $startdate
    Write-Host "Script running: " (Get-Date)
    Write-Host "Number of ressources: " ($resource | Measure-Object).Count
    $resource | Format-Table Name, ResourceGroupName
    Start-Sleep -Seconds 5
}