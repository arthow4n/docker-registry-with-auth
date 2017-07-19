#!/bin/bash
set -euo pipefail

cd "$(readlink -f "$(dirname "$0")")"

if [[ -d "./certs" ]]; then
  echo "Directory './certs' found, skip generating."
else
  openssl req -newkey rsa:2048 -nodes -keyout ./certs/auth-key.pem -x509 -days 365 -out ./certs/auth-cert.pem
  openssl dhparam -out ./certs/dhparam.pem 2048
  echo "Generated './certs'."
fi

if grep /path/to/letsencrypt docker-compose.yml 2>&1 >/dev/null; then
  echo "Replace cert path in './docker-compose.yml => services => nginx => volumes' before running."
fi

if grep example.com *.yml | grep -v 'domain: '; then
  echo "Replace 'example.com' with your domain name in 'registry-config.yml => auth'."
fi

if grep '^#' registry-auth-config.yml; then
  echo "Uncomment at least 1 authentication methods in 'registry-config.yml' before running."
fi
