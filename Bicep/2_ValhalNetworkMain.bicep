targetScope = 'subscription'
param vnetname string = 'ValhalVnet'
param vnetAdressSpace string = '10.0.0.0/16'

resource valhalNetworkRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'Valhal-Network'
  location: az.deployment().location
}
  
module Network 'Network.bicep' = {
  scope: resourceGroup(valhalNetworkRG.name)
  name: 'ValhalVnet'
  params: {
    location: valhalNetworkRG.location
    vnetname: vnetname
    vnetAdressSpace:vnetAdressSpace
  }
}


