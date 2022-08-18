#!/bin/bash

# Gitpod-only.

echo "ASTRA DB CONFIGURATION"

read -p "Enter Client ID from token: " CLIENT_ID

read -sp "Enter Client Secret from token : " CLIENT_SECRET
echo ""

DEFAULT_SECURE_BUNDLE=`ls jupyter/secureconnect/*.zip | head -n 1`
DEFAULT_SECURE_BUNDLE=${DEFAULT_SECURE_BUNDLE:-jupyter/secureconnect/secure-connect-workshops.zip}
echo "Please drag-and-drop your secure bundle zip file to jupyter/secureconnect NOW"
read -p "Enter secure-connect-bundle location [${DEFAULT_SECURE_BUNDLE}]: " SECURE_BUNDLE
SECURE_BUNDLE=${SECURE_BUNDLE:-${DEFAULT_SECURE_BUNDLE}}

read -p "Enter keyspace [machine_learning]: " KEYSPACE
KEYSPACE=${KEYSPACE:-machine_learning}

#
FIXED_BUNDLE=$(printf '%s\n' "${SECURE_BUNDLE/jupyter/.}" | sed -e 's/[\/&]/\\&/g')
cat jupyter/.env.sample \
  | sed "s/client_id_from_Astra_DB_token/${CLIENT_ID}/g" \
  | sed "s/client_secret_from_Astra_DB_token/${CLIENT_SECRET}/g" \
  | sed "s/.\/secureconnect\/secure-connect-workshops.zip/${FIXED_BUNDLE}/g" \
  | sed "s/machine_learning/${KEYSPACE}/g" \
  > jupyter/.env


JUPYTER_URL="$(gp url 8888)"
echo -e "\n\n\n\n\n\t\t** OPENING JUPYTER IN NEW TAB. PLEASE CHECK YOUR POP-UP BLOCKER **\n";
gp preview --external ${JUPYTER_URL}
