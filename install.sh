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

echo "Adding home-manager..."
# Setup the channels
nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager
echo "Upgrading to nixos-unstable..."
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
echo "Updating channels..."
nix-channel --update

echo "Installing..."
nixos-rebuild switch
home-manager switch -f $(pwd)/profiles/personal.nix -b backup
clear
echo "Finished!"
