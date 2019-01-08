#!/bin/bash

GIT_BRANCH=$(git symbolic-ref --short -q HEAD)
if [ $GIT_BRANCH != $HOSTNAME ]; then
  echo "On branch $GIT_BRANCH that differs from hostname $HOSTNAME, trying to check out the correct branch:"
  sudo git checkout $HOSTNAME
fi
if [ $GIT_BRANCH = $HOSTNAME ]; then
  echo "Using \"$GIT_BRANCH\":"
  echo "Copying configuration"
  sudo cp -R *.nix /etc/nixos/
  echo "Copying dotfiles"
  sudo rm -rf /etc/nixos/dotfiles && mkdir -p /etc/nixos/dotfiles
  sudo cp -R dotfiles/$HOSTNAME /etc/nixos/dotfiles/
  echo "Finished copying files"
  sudo nixos-rebuild switch
else
  echo "Failed checking out the branch for $HOSTNAME. Aborting."
fi
