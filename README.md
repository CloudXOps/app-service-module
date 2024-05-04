
## Installation

Terraform on debian based linux distros

- wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
- echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
- sudo apt update && sudo apt install terraform

Azure cli on debian based linux distros

- sudo apt-get update
- sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg
- curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
- AZ_REPO=$(lsb_release -cs)
- echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
- sudo apt-get update
- sudo apt-get install azure-cli

## Authentication 

Create Azure Service Principal
```
az ad sp create-for-rbac --name ServicePrincipalName --role Contributor --scopes /subscriptions/SubscriptionId
```

Set the environmental variables to authenticate to the azure subscription

- export ARM_CLIENT_ID="your_client_id"
- export ARM_CLIENT_SECRET="your_client_secret"
- export ARM_SUBSCRIPTION_ID="your_subscription_id"
- export ARM_TENANT_ID="your_tenant_id"

## How to use

Add the below block in root module

```
module "azure_app_service" {
    source = "git::https://github.com/CloudXOps/app-service-module?ref=v1.0.0"
    # Required Variables
}
```

