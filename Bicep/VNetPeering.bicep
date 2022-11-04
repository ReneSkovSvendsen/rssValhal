param peeringVNet string
param remotePeeringVNet string

resource peeringVNetResource 'Microsoft.Network/virtualNetworks@2022-05-01' existing = {
  name: peeringVNet
}

resource remotePeeringVNetResource 'Microsoft.Network/virtualNetworks@2022-05-01' existing = {
  name: remotePeeringVNet
}

resource vnetPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-05-01' = {
  name: 'hub2main'
  parent: peeringVNetResource
  properties: {
    allowForwardedTraffic: true
    allowGatewayTransit: bool
    allowVirtualNetworkAccess: bool
    doNotVerifyRemoteGateways: bool
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteAddressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    remoteVirtualNetwork: {
      id: remotePeeringVNetResource.id
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    useRemoteGateways: bool
  }
}
