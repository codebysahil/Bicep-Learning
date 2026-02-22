param resourceLocation string = resourceGroup().location
resource azureKeyVault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  location: resourceLocation
  name:'akvProd001'
  properties:{
    tenantId: subscription().tenantId
    createMode: 'default'
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    enablePurgeProtection: true
    enableRbacAuthorization: true
    enableSoftDelete: true
    publicNetworkAccess:  'Disabled'
    sku:{
      family: 'A'
      name: 'standard'
      
    }
    
    softDeleteRetentionInDays: 30

  }
  



}

output keyVaultUri string = azureKeyVault.properties.vaultUri
output keyVaultId string = azureKeyVault.id
output keyVaultName string = azureKeyVault.name
output location string = azureKeyVault.location
output resourceGroupName string = resourceGroup().name

output enableRbacAuthorization bool = azureKeyVault.properties.enableRbacAuthorization
output publicNetworkAccess string = azureKeyVault.properties.publicNetworkAccess
output softDeleteRetentionInDays int = azureKeyVault.properties.softDeleteRetentionInDays
output skuName string = azureKeyVault.properties.sku.name
output skuFamily string = azureKeyVault.properties.sku.family
