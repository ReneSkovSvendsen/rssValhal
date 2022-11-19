targetScope = 'subscription'
param vnetname string = 'ValhalNetHub'
param bastionSubnet string = '172.16.0.0/24'
param location string = az.deployment().location
param deployBastian bool

resource valhalNetworkRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'Valhal-Network'
  location: location
}
  
module Bastion 'ValhalBastion.bicep' = if (deployBastian) {
  name: 'ValhalBastion'
  scope: resourceGroup(valhalNetworkRG.name)
  params:{
    location: valhalNetworkRG.location
    vnetname: vnetname
    bastionSubnet:bastionSubnet
  }
}

