{ config, pkgs, lib, ... }:

let
  imports = [
    ../packages/starship.nix
  ];
in {
  inherit imports;
  starship = {
    enable = true;
    userConfig = ../config/starship.toml;
  };
}
