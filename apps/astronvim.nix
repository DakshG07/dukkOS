{ config, pkgs, lib, ... }:

let
  imports = [
    ../packages/astronvim.nix
  ];
in {
  inherit imports;
  options.astronvim = {
    enable = true;
    userConfig = ../config/nvim;
  };
}
