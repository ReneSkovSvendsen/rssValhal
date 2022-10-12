param location string

resource r_ValhalSingleVMPublicIP 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: 'ValhalSingleVMPublicIP'
  sku: {
    tier: 'Regional'
    name: 'Standard'
  }
  properties:{
    publicIPAllocationMethod:'Static'
  }
  location: location
}
