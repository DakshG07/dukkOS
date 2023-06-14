{ config, pkgs, lib, ... }:

let
  # Custom configs
  imports = [
    ../apps/wezterm.nix
  ];
in
{
  inherit imports;
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dukk";
  home.homeDirectory = "/home/dukk";

  home.stateVersion = "23.05";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # CLIs
    gh
    git
    neofetch
    # Editors
    neovim
    # GUIs
    firefox
    wezterm
    thunderbird
    # Fonts
    recursive
  ];

  # Custom configs
  wezterm.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
