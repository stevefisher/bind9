#!/bin/bash

# Script to insert the bind9 tsig key from vault

file="named.conf.key"
search_string="TSIGKEY"

if grep -q "$search_string" "$file"; then
        if [ -z "$VAULT_TOKEN" ]; then
                read -p "Enter the vault access token: " INPUT_VALUE
                export VAULT_TOKEN="$INPUT_VALUE"
                echo "Vault token has been set to $VAULT_TOKEN"
        fi

        if [ -z "$VAULT_ADDR" ]; then
                read -p "Enter the vault access token: " INPUT_VALUE2
                export VAULT_ADDR="$INPUT_VALUE2"
                echo "Vault token has been set to $VAULT_ADDR"
        fi

        TSIG_KEY=$(vault kv get -mount=secret -field=tsig-key bind9-tsig-key)
        sed -i "s#$search_string#$TSIG_KEY#" "$file"
        echo "named.conf.key had been configured"
else
        echo "named.conf.key has already been configured"
fi