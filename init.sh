#!/bin/sh
set -e

# set channel to stable, alpha, beta
CHANNEL=stable
BOX=flatcar_production_vagrant.box
WORKING_DIR=config
SIGNING_KEY=Flatcar_Image_Signing_Key.asc

mkdir -p $WORKING_DIR && cd $_

if [[ -z `gpg --list-keys | grep "Flatcar Buildbot"` ]]; then
  if [ ! -f "$SIGNING_KEY" ]; then
    echo "Fetching image signing key ..."
    curl --fail -L -O https://flatcar-linux.org/security/image-signing-key/$SIGNING_KEY
  fi
  gpg --import --keyid-format LONG $SIGNING_KEY
fi

if [[ -z `vagrant box list | grep "flatcar-$CHANNEL"` ]]; then
  echo "Creating box flatcar-$CHANNEL ..."
  if [ ! -f "$BOX" ]; then
    curl --fail -L -O https://$CHANNEL.release.flatcar-linux.net/amd64-usr/current/$BOX
    curl --fail -L -O https://$CHANNEL.release.flatcar-linux.net/amd64-usr/current/$BOX.sig
    gpg --verify $BOX.sig
  fi

  # add box to Vagrant
  vagrant box add flatcar-$CHANNEL $BOX
else
  echo "ALREADY UP TO DATE"
fi

cd -

if [ ! -f "Vagrantfile" ]; then
  vagrant init flatcar-$CHANNEL
fi

echo "DONE"
