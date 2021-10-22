@description('The Azure region to host in.')
param location string

@description('The name of the appllication hosted in the App Service')
param appServiceAppName string

@allowed([
  'nonProd'
  'prod'
])
param environmentType string

var appServicePlanName = 'toy-product-launch-plan'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2_v3' : 'F1' // F1 == free tier


resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2021-02-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

@description('The FQDN of the deployed app service so you can deploy code to it.')
output appServiceAppHostName string = appServiceApp.properties.defaultHostName
