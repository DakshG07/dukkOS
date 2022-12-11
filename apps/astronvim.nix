{ config, pkgs, lib, ... }:

let
  imports = [
    ../packages/astronvim.nix
  ];
in {
  inherit imports;
  astronvim = {
    enable = true;
    userConfig = ../config/nvim;
  };
}
