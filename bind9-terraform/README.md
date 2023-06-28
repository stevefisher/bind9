## DNS Authentication

Create a file named credentials.auto.tfvars containing

`tsig_key = "<YOUR TSIG KEY GOES HERE>"`

## Configure Vault CLI

`$env:VAULT_ADDR="http://172.16.1.43:8200"`
`$env:VAULT_TOKEN= "<YOUR VAULT TOKEN GOES HERE>"`

## Create AWS Creds in Vault

`vault kv put -mount=secret aws_devops_3_access_and_secret_keys_test access_key=<AWS ACCESS KEY> secret_key=<AWS SECRET KEY>`

## Retrieve Creds from Vault

`vault kv get -mount secret -field=access_key aws_devops_3_access_and_secret_keys`
`vault kv get -mount secret -field=secret_key aws_devops_3_access_and_secret_keys`

## Initialise Terraform

```powershell
$env:AWS_ACCESS_KEY_ID="$(vault kv get -mount secret -field=access_key aws_devops_3_access_and_secret_keys)"
$env:AWS_SECRET_ACCESS_KEY="$(vault kv get -mount secret -field=secret_key aws_devops_3_access_and_secret_keys)"
```

`terraform init -backend-config="access_key=$($env:AWS_ACCESS_KEY_ID)" -backend-config="secret_key=$($env:AWS_SECRET_ACCESS_KEY)"`
