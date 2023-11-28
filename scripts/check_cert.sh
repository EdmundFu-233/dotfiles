#!/bin/bash
# Check SSL certificate expiration
DOMAIN="${1:-example.com}"

echo "Checking certificate for $DOMAIN..."
echo | openssl s_client -servername "$DOMAIN" -connect "$DOMAIN":443 2>/dev/null | \
    openssl x509 -noout -dates -subject -issuer
