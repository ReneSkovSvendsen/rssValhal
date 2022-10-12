param vnetname string
param subnetname string
param subnetPrefix string

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: vnetname
}

resource subnets 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  name: subnetname
  properties:{
    addressPrefix: subnetPrefix
  }
  parent: vnet
}
