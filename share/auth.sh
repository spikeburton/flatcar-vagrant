#!/bin/sh
set -e

mkdir -p $(pwd)/auth
docker run --rm --entrypoint htpasswd registry:latest \
  -Bbn moby gordon > $(pwd)/auth/htpasswd
