#!/bin/bash
set -euo pipefail

cd "$(readlink -f "$(dirname "$0")")"

if [[ -d "./certs" ]]; then
  echo "Directory './certs' found, skip generating."
else
  mkdir -p "./certs"
  openssl req -newkey rsa:2048 -nodes -subj '/CN=mydockerregistry.example.com/O=My Docker Registry/C=TW' -x509 -days 365 -keyout "./certs/auth-key.pem" -out "./certs/auth-cert.pem"
  openssl dhparam -out ./certs/dhparam.pem 2048
  echo "Generated './certs'."
fi

if grep /path/to/letsencrypt docker-compose.yml 2>&1 >/dev/null; then
  echo "Replace cert path in './docker-compose.yml => services => nginx => volumes' before running."
fi

if grep example.com registry-config.yml | grep -v 'domain: '; then
  echo "Replace 'example.com' with your domain name in 'registry-config.yml => auth'."
fi

if grep example.com registry-auth-config.yml | grep -v 'domain: '; then
  echo "Replace 'example.com' with your domain name in 'registry-auth-config.yml => token => issuer'."
fi

if grep '^#' registry-auth-config.yml; then
  echo "Uncomment at least 1 authentication methods in 'registry-config.yml' before running."
fi
