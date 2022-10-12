param location string
param vnetname string
param vnetAdressSpace string

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetname
  location: location
  properties:{
    addressSpace: {
      addressPrefixes: [
        vnetAdressSpace
      ]
    }
  }
}

