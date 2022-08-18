#!/bin/bash

# get cqlsh
mkdir bin
curl -L https://downloads.datastax.com/enterprise/cqlsh-astra.tar.gz -o bin/cqlsh-astra.tar.gz
tar -xvf bin/cqlsh-astra.tar.gz -C bin/
rm -f bin/cqlsh-astra.tar.gz
# get dsbulk
curl -L https://downloads.datastax.com/dsbulk/dsbulk-1.9.1.tar.gz -o bin/dsbulk-1.9.1.tar.gz
tar -xvf bin/dsbulk-1.9.1.tar.gz -C bin/
rm -f bin/dsbulk-1.9.1.tar.gz
# launch docker containers
docker-compose up -d
