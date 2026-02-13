@secure()
param regionLocation string = resourceGroup().location
param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'nameapptoycompany6067'

@allowed([
  'prod'
  'nonprod'
])
param environmentType string

var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'


resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01'= {

  name: storageAccountName

  location: regionLocation
  sku: {
    name: storageAccountSkuName
  }
  kind:'StorageV2'
  properties:{
    accessTier: 'Hot'

  }
  
}

module app 'appService.bicep' = {
  name: 'app' 
  params: {
    appServiceAppName: appServiceAppName
    environmentType: environmentType
    regionLocation: regionLocation
  }
}




output appServiceHostName string = app.outputs.appServiceHostName
