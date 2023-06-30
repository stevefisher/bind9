#!/bin/bash

# check all directories have been created

directories=("cache" "config" "records")

for directory in "${directories[@]}"; do
        if [[ ! -d "$directory" ]]; then
                mkdir "$directory"
                echo "Created directory: $directory"
        fi
        chmod 777 $directory
done

# Create the named.conf.key file from it's template and insert the bind9 tsig key from vault to keep it outside of source control

file="./config/named.conf.key"
search_string="TSIGKEY"

if [[ ! -f "$file" ]]; then
        echo "named.conf.key has not been found"
        if [ -z "$VAULT_TOKEN" ] || [ -z "$VAULT_ADDR" ]; then
                if [ -z "$VAULT_TOKEN" ]; then
                        echo "Please set the VAULT_TOKEN environment variable before running this script"
                fi
                if [ -z "$VAULT_ADDR" ]; then
                        echo "Please set the VAULT_ADDR environment variable before running this script"
                fi
        else
                cp $file.template $file
                echo "named.conf.key has been created"

                if grep -q "$search_string" "$file"; then
                        # obtain the tsig key from vault
                        export TSIG_KEY=$(vault kv get -mount=secret -field=tsig-key bind9-tsig-key)
                        # replace the search_string in named.conf.key with the tsig key
                        sed -i "s#$search_string#$TSIG_KEY#" "$file"
                        echo "named.conf.key has been configured"
                fi
        fi
else
        echo "named.conf.key already exists"
fi