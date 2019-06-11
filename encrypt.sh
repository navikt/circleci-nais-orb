#!/usr/bin/env bash
set -eo pipefail

[[ -z "$1" || -z "$2" ]] && echo "Usage: ./encrypt.sh path-to-key-file path-to-circleci-folder" && exit

KEY=$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'A-F0-9' | fold -w 64 | head -n 1) || true
IV=$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'A-F0-9' | fold -w 32 | head -n 1) || true

openssl aes-256-cbc -K $KEY -iv $IV -in $1 -out $2/github.key.pem.enc

echo "OPENSSL_KEY=$KEY"
echo "OPENSSL_IV=$IV"
