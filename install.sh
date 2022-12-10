#!/usr/bin/env bash

# Needs root
id="$(id -g)"

if [ $id -ne 0 ]
then
    echo "Please run as root.";
    exit 1;
fi

echo "Linking files..."
# Link file
ln -s $(pwd)/os/configuration.nix /etc/nixos/configuration.nix

echo "Add home-manager..."
# Setup the channels
nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager
nix-channel --update
