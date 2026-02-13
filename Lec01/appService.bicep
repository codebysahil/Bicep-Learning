param regionLocation string
param appServiceAppName string

var appServicePlanName = 'toy-product-launch-plan889182'
@allowed([
  'prod'
  'nonprod'
])
param environmentType string

var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'F1'

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name:appServicePlanName
  location: regionLocation
  sku: {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  location: regionLocation
  name: appServiceAppName
  properties:{
    serverFarmId:appServicePlan.id
    httpsOnly: true

  }

}

output appServiceHostName string = appServiceApp.properties.defaultHostName
