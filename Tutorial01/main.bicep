@description('The azure region to host in.  Defaults to the location of the target Resource Group.')
param location string = resourceGroup().location
param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'toylaunch${uniqueString(resourceGroup().id)}'


@allowed([
  'nonProd'
  'prod'
])
param environmentType string
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

module appService 'modules/appService.bicep' = {
  name: 'appService'
  params: {
    environmentType: environmentType
    location: location
    appServiceAppName: appServiceAppName
  }
}

@description('The FQDN of the App Service so you can deploy/test connect to it.')
output appServiceAppHostName string = appService.outputs.appServiceAppHostName // pass-through from module
