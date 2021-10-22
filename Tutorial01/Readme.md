From the MSDocs @ https://docs.microsoft.com/en-us/learn/modules/build-first-bicep-template/, where they 
have a sandpit Azure subscriptoion to target, but the basic steps are:



As whichever account you want to play on:
``` ps
az login 
az account set --subscription your-VS-subscription-guid-here-free-yay
```

Create a resource group in the portal to isolate everything we create for easy deletion, then run the below to make it the default target so you need to keep speifying over and over
``` ps
az configure --defaults group=your-new-resource-group-name-here
```

We have a module for creating an AppServicePlan and App on it, and a main template that calls that and creates a storage account

Diff config per environment baked into the templates, param files coming in a later tutorial
``` ps
az deployment group create --template-file .\main.bicep --parameters environmentType=nonProd
```