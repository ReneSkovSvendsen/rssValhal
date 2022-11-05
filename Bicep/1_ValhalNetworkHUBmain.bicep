targetScope = 'subscription'
param vnetname string = 'ValhalNetHub'
param vnetadressSpace string = '172.16.0.0/16'
param bastionSubnet string = '172.16.0.0/24'
param location string = az.deployment().location
param deployBastian bool = true

resource valhalNetworkRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'Valhal-Network'
  location: location
}
  
module Network 'Network.bicep' = {
  scope: resourceGroup(valhalNetworkRG.name)
  name: 'ValhalNetHub'
  params: {
    location: valhalNetworkRG.location
    vnetname: vnetname
    vnetAdressSpace:vnetadressSpace
  }
  
}
module RouteServerSubnet 'Subnets.bicep' = {
  scope: resourceGroup(valhalNetworkRG.name)
  name: 'RouteServerSubnet'
  params:{
    subnetPrefix: '172.16.1.0/24'
    subnetname: 'RouteServerSubnet'
    vnetname: vnetname
  } 
  }

module AzureFirewallSubnet 'Subnets.bicep' = {
  scope: resourceGroup(valhalNetworkRG.name)
  name: 'AzureFirewallSubnet'
  params: {
    subnetPrefix: '172.16.2.0/24'
    subnetname: 'AzureFirewallSubnet'
    vnetname: vnetname
  }
}

module Bastion 'ValhalBastion.bicep' = if (deployBastian) {
  name: 'ValhalBastion'
  scope: resourceGroup(valhalNetworkRG.name)
  dependsOn:[
    Network
  ]
  params:{
    location: valhalNetworkRG.location
    vnetname: vnetname
    bastionSubnet:bastionSubnet
  }
}

