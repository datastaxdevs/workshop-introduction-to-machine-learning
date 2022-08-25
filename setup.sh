#!/bin/bash

astra setup

# -- Env Variables --
CLIENT_ID=token
CLIENT_SECRET=`astra config get default --key ASTRA_DB_APPLICATION_TOKEN`
DB_NAME=workshops
KEYSPACE=machine_learning
SECURE_BUNDLE=./secureconnect/secure-connect-workshops.zip

## -- Create DB --
astra db create ${DB_NAME} -k ${KEYSPACE} --if-not-exist
astra db list
astra db get ${DB_NAME}

## -- Secure Bundle --
astra db download-scb ${DB_NAME} -f ${SECURE_BUNDLE}

## -- .env -- 
cat jupyter/.env.sample | sed "s/client_secret_from_Astra_DB_token/${CLIENT_SECRET}/g" > jupyter/.env
echo -e "\n\n** Dotenv file created. Please wait 1-2 minutes while we populate your database ...\n\n";

## -- Initialize --
./initialize/initialize.sh

echo -e "\n\n\n\n** Tables created and populated.";
JUPYTER_URL="$(gp url 8888 2>/dev/null)"
if [ -n "${JUPYTER_URL}" ]; then
  echo -e "\n\t\t** OPENING JUPYTER IN NEW TAB. PLEASE CHECK YOUR POP-UP BLOCKER **\n";
  echo -e "\t\t** TARGET URL: ${JUPYTER_URL} **";
  gp preview --external ${JUPYTER_URL};
else
  JUPYTER_URL="http://localhost:8888/"
  echo -e "\n\t\t** PLEASE POINT YOUR BROWSER TO ${JUPYTER_URL} **\n";
fi
