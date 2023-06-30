#!/bin/bash

if [ -z "$VAULT_TOKEN" ] || [ -z "$VAULT_ADDR" ] || [ -z "$TSIG_KEY" ]; then
    if [ -z "$VAULT_TOKEN" ]; then
            echo "Please set the VAULT_TOKEN environment variable before running this script"
    fi
    if [ -z "$VAULT_ADDR" ]; then
            echo "Please set the VAULT_ADDR environment variable before running this script"
    fi
else
    if [ -z "$AWS_ACCESS_KEY_ID" ]; then
        export AWS_ACCESS_KEY_ID="$(vault kv get -mount secret -field=access_key aws_devops_3_access_and_secret_keys)"
        echo "AWS_ACCESS_KEY_ID has been set"
    fi
    if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
        export AWS_SECRET_ACCESS_KEY="$(vault kv get -mount secret -field=secret_key aws_devops_3_access_and_secret_keys)"
        echo "AWS_SECRET_ACCESS_KEY has been set"
    fi
    if [ -z "$TSIG_KEY" ]; then
        export TSIG_KEY="$(vault kv get -mount=secret -field=tsig-key bind9-tsig-key)"
        echo "TSIG_KEY has been set"
    fi
fi