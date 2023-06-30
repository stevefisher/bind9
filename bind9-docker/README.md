## Setup environment

Before calling `./setup.sh` to retrieve secrets from Vault and configure the environment you need to set variables for Vault itself as follows:

```bash
export VAULT_TOKEN="<YOUR TOKEN GOES HERE>"
export VAULT_ADDR="<URL TO VAULT GOES HERE>"
```

Once that has been done you can call `./setup.sh`

## Docker

With the environment configured you can start the bind9 container with docker compose

```bash
sudo docker compose up -d
```