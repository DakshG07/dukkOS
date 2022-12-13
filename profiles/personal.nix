{ config, pkgs, lib, ... }:

let
  # Custom stuff
  imports = [
    ../apps/zsh.nix
    ../apps/astronvim.nix
    ../apps/starship.nix
  ];
in
{
  inherit imports;
  home = {
    username = "dukk";
    homeDirectory = "/home/dukk/";
    sessionVariables = {
      EDITOR = "nvim";
      GIT_EDITOR = "nvim";
    };
    packages = with pkgs; [
      bat
      exa
      ripgrep
      lazygit
      starship
      gh
    ];
    stateVersion = "22.05";
  };
  
  programs = {
    home-manager = {
      enable = true;
    };
  };
}
