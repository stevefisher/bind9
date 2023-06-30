## Setup environment

Before calling `./setup.sh` to retrieve secrets from Vault and configure the environment you need to set variables for Vault itself as follows:

```bash
export VAULT_TOKEN="<YOUR TOKEN GOES HERE>"
export VAULT_ADDR="<URL TO VAULT GOES HERE>"
```

Once that has been done you can call `./setup.sh` which will configure the variables:

AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
TSIG_KEY

Optionally you can skip `./setup.sh` completely and manually create the variables.

## Terraform

With the environment setup complete the project is ready to be initialised and requires a single variable for the tsig key which has been defined in the environment setup for us to reference.

```bash
terraform init

terraform plan -var="tsig_key=$TSIG_KEY"

terraform apply -var="tsig_key=$TSIG_KEY"
```