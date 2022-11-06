$resource = Get-AzResource
Clear-Host
while (($resource | Measure-Object).Count -ne 0) {
    Clear-Host
    Get-Date
    $resource = Get-AzResource
    $resource | Format-Table Name, ResourceGroupName
    Start-Sleep -Seconds 5
}