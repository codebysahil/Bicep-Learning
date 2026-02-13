param appServicePlan object = {
  name: 'F1'
  tier: 'Free'
  capacity:1
}
@description('Cosomos Db Locations and parameter should be a list of ojects')
param cosmosDBAccountLocations array = [
  {
    locationName: 'australiaeast'
  }
  {
    locationName: 'southcentralus'
  }
  {
    locationName: 'westeurope'
  }
]

@description('Cosomos Db Locations and parameter should be a list of ojects')
@allowed([
'P1v3'
'P2v3'
'P3v3'

])
param appServicePlanSkuName string

@maxLength(24)
@minLength(5)
param storageAccountName string





param resourceTags object = {
  EnvironmentName: 'Test'
  CostCenter: '00010101'
  Team: 'Human Resource'
  
}
