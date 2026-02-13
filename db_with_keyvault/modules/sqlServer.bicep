@description('The name of the SQL Server')
param sqlServerName string = 'sqlserver-${uniqueString(resourceGroup().id)}'

@description('The name of the SQL Database')
param sqlDatabaseName string = 'myDatabase'
@secure()
@description('The administrator username for SQL Server')
param administratorLogin string

@description('The administrator password for SQL Server')
@secure()
param administratorLoginPassword string

@description('The location for all resources')
param location string = resourceGroup().location

@description('The SKU name for the SQL Database')
@allowed([
  'Basic'
  'S0'
  'S1'
  'S2'
  'P1'
  'P2'
])
param databaseSku string = 'Basic'

resource sqlServer 'Microsoft.Sql/servers@2023-05-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    version: '12.0'
    publicNetworkAccess: 'Enabled'
  }
}

// Firewall rule to allow Azure services
resource allowAzureServices 'Microsoft.Sql/servers/firewallRules@2023-05-01-preview' = {
  parent: sqlServer
  name: 'AllowAllWindowsAzureIps'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

// Optional: Firewall rule to allow your current IP (update with your IP)
resource allowClientIp 'Microsoft.Sql/servers/firewallRules@2023-05-01-preview' = {
  parent: sqlServer
  name: 'AllowClientIp'
  properties: {
    startIpAddress: '0.0.0.0' // Replace with your IP
    endIpAddress: '0.0.0.0'   // Replace with your IP
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2023-05-01-preview' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location
  sku: {
    name: databaseSku
    tier: databaseSku
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 2147483648 // 2 GB
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    zoneRedundant: false
    readScale: 'Disabled'
  }
}

output sqlServerFqdn string = sqlServer.properties.fullyQualifiedDomainName
output sqlServerName string = sqlServer.name
output sqlDatabaseName string = sqlDatabase.name
output connectionString string = 'Server=tcp:${sqlServer.properties.fullyQualifiedDomainName},1433;Initial Catalog=${sqlDatabaseName};Persist Security Info=False;User ID=${administratorLogin};Password=<your_password>;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
