##Commands to run bicep:
```zsh
az deployment group create -g test-rg -f main1.bicep # the keyword "group" has been user for deploying the resources in ResourceGroup
# for making the scope to subscription, use:
az deployment sub create -f ./main.bicep --location eastus

# for creating ARM template from bicep code:
az Bicep build -f main.bicep --outfile main_arm_new.json
```