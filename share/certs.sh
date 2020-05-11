#!/bin/sh
set -e

ADDR=127.0.0.1
PORT=5000

mkdir -p $(pwd)/certs
openssl req -newkey rsa:4096 -nodes -sha256 \
  -keyout $(pwd)/certs/domain.key \
  -x509 -days 365 \
  -out $(pwd)/certs/domain.crt

CERTS_DIR=/etc/docker/certs.d/$ADDR:$PORT
sudo mkdir -p $CERTS_DIR
sudo cp $(pwd)/certs/domain.crt $CERTS_DIR/ca.crt
sudo systemctl restart docker
