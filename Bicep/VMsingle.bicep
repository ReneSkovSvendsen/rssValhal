param vnet string
param subnet string
//param location string

@description('VMName for server')
param vmName string
param location string = resourceGroup().location

resource vmName_vmName_scriptExtension 'Microsoft.Compute/virtualMachines/extensions@2021-03-01' = {
  parent: vmName_resource
  name: '${vmName}-scriptExtension'
  location: location
  tags: {
    displayName: 'scriptExtension for Windows VM'
  }
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.10'
    autoUpgradeMinorVersion: true
    settings: {
      fileUris: [
        'https://raw.githubusercontent.com/ReneSkovSvendsen/rssValhal/main/ValhalGenericScripts/InstallSSConf.ps1'
      ]
      commandToExecute: 'powershell -ExecutionPolicy Bypass -file InstallSSConf.ps1'
    }
    protectedSettings: {}
  }
}

resource vmName_NetworkInterface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: '${vmName}-NetworkInterface'
  location: location
  tags: {
    displayName: '${vmName} Network Interface'
  }
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Valhal-Network', 'Microsoft.Network/virtualNetworks/subnets', vnet, subnet)
          }
          publicIPAddress:{
            id:r_ValhalSingleVMPublicIP.id
          }
        }
      }
    ]
  }
}

resource vmName_resource 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: vmName
  location: location
  tags: {
    displayName: vmName
  }
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_A2_v2'
    }
    osProfile: {
      computerName: vmName
      adminUsername: 'resve'
      adminPassword: 'Zaea25252525'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        name: '${vmName}-VM01OSDisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }    
    networkProfile: {
      networkInterfaces: [
        {
          id: vmName_NetworkInterface.id
        }
      ] 
    }
  }
}


resource r_ValhalSingleVMPublicIP 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: 'ValhalSingleVMPublicIP'
  sku: {
    tier: 'Regional'
    name: 'Standard'
  }
  properties:{
    publicIPAllocationMethod: 'Static'
    
  }
  location: location
}
