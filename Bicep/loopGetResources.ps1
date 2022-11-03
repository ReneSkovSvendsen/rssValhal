Clear-Host
while (($resource | measure).Count -ne 0) {
    Clear-Host
    $resource = get-azresource
    $resource | Format-Table Name, ResourceGroup
    Start-Sleep -Seconds 2
}