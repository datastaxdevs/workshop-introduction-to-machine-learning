#!/bin/bash

echo "** ASTRA DB CONFIGURATION **";
echo "Enter the required information to connect to your Astra DB instance";
echo "(make sure you have a DB token and a Secure Connect Bundle zipfile)";

read -p "Enter Client ID from token     : " CLIENT_ID

read -p "Enter Client Secret from token : " CLIENT_SECRET

read -p "** Please drag-and-drop (i.e. copy) your secure bundle zip file to jupyter/secureconnect NOW. Press Enter when ready **" DUMMY

# we copy zip files downstairs
ROOTDIR_SECURE_BUNDLE=`ls *.zip | head -n 1`
if [ -n "${ROOTDIR_SECURE_BUNDLE}" ]; then
  cp "${ROOTDIR_SECURE_BUNDLE}" jupyter/secureconnect/;
fi

DEFAULT_SECURE_BUNDLE=`ls jupyter/secureconnect/*.zip | head -n 1`
DEFAULT_SECURE_BUNDLE=${DEFAULT_SECURE_BUNDLE:-jupyter/secureconnect/secure-connect-workshops.zip}
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

echo -e "\n\n** Dotenv file created. Please wait 1-2 minutes while we populate your database ...\n\n";

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
