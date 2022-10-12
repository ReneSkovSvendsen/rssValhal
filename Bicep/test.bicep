targetScope = 'subscription'

output out string = resourceId('Microsoft.Network/bastionHosts', 'ValhalBastion')
output isTrue bool = (resourceId('Microsoft.Network/bastionHosts', 'ValhalBastion') != '')
