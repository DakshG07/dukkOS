{ config, pkgs, lib, ... }:

let
  imports = [
    ../packages/astro.nix
  ];
in {
  options.astronvim = {
    enable = true;
    userConfig = ../config/nvim;
  };
}
