targetScope = 'subscription'
param vnetname string = 'ValhalVnet'
param vnetAdressSpace string = '10.0.0.0/16'
param location string = az.deployment().location

resource valhalNetworkRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'Valhal-Network'
  location: location
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


