{ config, pkgs, lib, ... }:

let
  imports = [
    ../packages/astro.nix
  ];
in {
  inherit imports;
  options.astronvim = {
    enable = true;
    userConfig = ../config/nvim;
  };
}
