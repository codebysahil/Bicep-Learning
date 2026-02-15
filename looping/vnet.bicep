param rgLocation string = resourceGroup().location
param addressPrefixes array = [
  '10.0.0.0/16'
  '10.1.0.0/16'
]
param subnetData array = [

{
  name: 'subnet1'  
  addressPrefix: '10.0.1.0/24'
 
}


{
  name: 'subnet2'  
  addressPrefix: '10.1.1.0/24'

}


]

resource vnet_main 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  name: 'vnet${uniqueString(resourceGroup().id)}'
  location: rgLocation
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
  }
}


resource subnets 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' = [for subnet in subnetData : {
  
name: subnet.name
parent: vnet_main
properties: {
  addressPrefix: subnet.addressPrefix
}
}
]
