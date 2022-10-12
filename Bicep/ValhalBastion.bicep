param location string
param vnetname string
param bastionSubnet string

resource vNet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: vnetname
}

resource r_bastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  name: 'AzureBastionSubnet'
  parent: vNet
  properties: {
    addressPrefix: bastionSubnet
  }
}

resource r_ValhalBastionPublicIP 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: 'ValhalBastionPublicIP'
  sku: {
    tier: 'Regional'
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
  location: location
}

resource ValhalBastion 'Microsoft.Network/bastionHosts@2021-05-01' = {
  name: 'ValhalBastion'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    ipConfigurations: [
      {
        name: 'AzureValhalBastionName'
        properties: {
          publicIPAddress: {
            id: r_ValhalBastionPublicIP.id
          }
          subnet: {
            id: r_bastionSubnet.id
          }
        }
      }
    ]
    scaleUnits: 2
  }
}
