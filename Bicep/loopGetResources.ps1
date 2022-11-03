cls
while (($resource | measure).Count -ne 0) {
    cls
    $resource = get-azresource
    $resource | ft Name, ResourceGroup
    Start-Sleep -Seconds 2
}