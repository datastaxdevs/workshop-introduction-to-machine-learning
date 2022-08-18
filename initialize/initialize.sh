#!/bin/bash

# get astra cli - TODO

# prepare dot env file - TODO. Now we assume .env is there already

source ./jupyter/.env

# make create-tables script
cat initialize/create_tables.cql.template | sed "s/%KEYSPACE_NAME%/${ASTRA_DB_KEYSPACE}/g" > initialize/create_tables.cql

# run create-tables script
./bin/cqlsh-astra/bin/cqlsh \
  -u "${ASTRA_DB_CLIENT_ID}" \
  -p "${ASTRA_DB_CLIENT_SECRET}" \
  -b "jupyter/${ASTRA_DB_SECURE_BUNDLE_PATH}" \
  -f initialize/create_tables.cql

# dsbulk calls to populate tables
./bin/dsbulk-1.9.1/bin/dsbulk \
  load \
  -url jupyter/data/socialMedia.csv \
  -c csv \
  -delim ',' \
  -m "status_id,social_type,num_reactions,num_comments,num_shares,num_likes,num_loves,num_wows,num_hahas,num_sads,num_angrys" \
  -header false \
  -k "${ASTRA_DB_KEYSPACE}" \
  -t socialmedia \
  -u "${ASTRA_DB_CLIENT_ID}" \
  -p "${ASTRA_DB_CLIENT_SECRET}" \
  -b "jupyter/${ASTRA_DB_SECURE_BUNDLE_PATH}" \

./bin/dsbulk-1.9.1/bin/dsbulk \
  load \
  -url jupyter/data/winequality.csv \
  -c csv \
  -delim ',' \
  -m "wineid,fixedacidity,volatileacidity,citricacid,sugar,chlorides,freesulfur,totalsulfur,density,ph,sulphates,alcohol,quality" \
  -header false \
  -k "${ASTRA_DB_KEYSPACE}" \
  -t wines \
  -u "${ASTRA_DB_CLIENT_ID}" \
  -p "${ASTRA_DB_CLIENT_SECRET}" \
  -b "jupyter/${ASTRA_DB_SECURE_BUNDLE_PATH}" \

./bin/dsbulk-1.9.1/bin/dsbulk \
  load \
  -url jupyter/data/ratings.csv \
  -c csv \
  -delim ',' \
  -m "userid,movieid,rating,timestamp" \
  -header false \
  -k machine_learning \
  -t movieratings \
  -u "${ASTRA_DB_CLIENT_ID}" \
  -p "${ASTRA_DB_CLIENT_SECRET}" \
  -b "jupyter/${ASTRA_DB_SECURE_BUNDLE_PATH}" \

./bin/dsbulk-1.9.1/bin/dsbulk \
  load \
  -url jupyter/data/movies.csv \
  -c csv \
  -delim ',' \
  -m "movieid,title,genres" \
  -header false \
  -k machine_learning \
  -t movies \
  -u "${ASTRA_DB_CLIENT_ID}" \
  -p "${ASTRA_DB_CLIENT_SECRET}" \
  -b "jupyter/${ASTRA_DB_SECURE_BUNDLE_PATH}" \

./bin/dsbulk-1.9.1/bin/dsbulk \
  load \
  -url jupyter/data/jester_ratings3.csv \
  -c csv \
  -delim ',' \
  -m "userid,jokeid,rating" \
  -header false \
  -k machine_learning \
  -t jokes \
  -u "${ASTRA_DB_CLIENT_ID}" \
  -p "${ASTRA_DB_CLIENT_SECRET}" \
  -b "jupyter/${ASTRA_DB_SECURE_BUNDLE_PATH}" \
