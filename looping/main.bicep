// script to create 2 storage accounts

param location string = resourceGroup().location
param storageAccountCount int = 2

resource storageAccnt 'Microsoft.Storage/storageAccounts@2023-01-01' = [ for i in range(0,storageAccountCount):{
 name: 'stg${i}${take(uniqueString(subscription().id, resourceGroup().name), 10)}'

  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}]



output storageAccountDetails array = [for i in range(0,storageAccountCount): {
  id: storageAccnt[i].id
  blobEndpoint: storageAccnt[i].properties.primaryEndpoints.blob
  status: storageAccnt[i].properties.statusOfPrimary

}
]
