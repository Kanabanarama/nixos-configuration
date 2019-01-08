#!/bin/bash

echo "Copying configuration for $HOSTNAME"
sudo cp -R *.nix /etc/nixos/
echo "Copying dotfiles"
sudo rm -rf /etc/nixos/dotfiles && mkdir -p /etc/nixos/dotfiles
sudo cp -R dotfiles/$HOSTNAME /etc/nixos/dotfiles/
echo "Finished copying files"
sudo nixos-rebuild switch
