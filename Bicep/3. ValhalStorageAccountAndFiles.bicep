targetScope = 'subscription'

resource StorageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: "ValhalStorageAcc"
  location:
  properties: {
    allowBlobPublicAccess:true
  }
}
