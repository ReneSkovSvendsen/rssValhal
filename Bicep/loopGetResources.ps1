$resource = Get-AzResource
Clear-Host
while (($resource | Measure-Object).Count -ne 0) {
    Clear-Host
    $resource | Format-Table Name, ResourceGroup
    Start-Sleep -Seconds 2
}