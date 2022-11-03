targetScope = 'subscription'
param vnetRGName string = 'Valhal-Network'
param vnetname string = 'ValhalVnet'
param subnet1 string = 'Subnet-1'
param location string = az.deployment().location

resource valhalWindowsSrvRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'Valhal-WindowsSRV'
  location: location
}

module valhalserversubnet 'Subnets.bicep' = {
  name: 'valhalserversubnet'
  scope: resourceGroup(vnetRGName)
  params: {
    subnetname: subnet1
    vnetname: vnetname
    subnetPrefix: '10.0.2.0/24'
  }  
}

module valhalSingleWINServer 'VMsingle.bicep' =  {
  name: 'ValhalSingleWINServer'
  scope: resourceGroup(valhalWindowsSrvRG.name)
  dependsOn:[
    valhalserversubnet
  ]
  params:{
    vmName: 'VM01'
    subnet: subnet1
    vnet: vnetname
    location: valhalWindowsSrvRG.location
  }
  
}

