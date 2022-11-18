targetScope = 'subscription'
param vnetname string = 'ValhalVnet'
param location string = az.deployment().location
param vmname string
param subnetname string

resource valhalWindowsSrvRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'Valhal-WindowsSRV'
  location: location
}

resource valhalServerSubnet 'Microsoft.Network/virtualNetworks/subnets@2022-05-01' existing = {
  name: subnetname
  scope: resourceGroup(valhalWindowsSrvRG.name)
}

module valhalSingleWINServer1 'VMsingle.bicep' =  {
  name: 'ValhalSingleWINServer-${vmname}'
  scope: resourceGroup(valhalWindowsSrvRG.name)
  dependsOn:[
    valhalServerSubnet
  ]
  params:{
    vmName: vmname
    subnet: valhalServerSubnet.name
    vnet: vnetname
    location: valhalWindowsSrvRG.location
  }
  
}

