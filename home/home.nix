{ config, pkgs, lib, hyprland, ... }:

let
  # Custom configs
  imports = [
    ../apps/wezterm.nix
    ../apps/hyprland.nix
    hyprland.homeManagerModules.default
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
    # Tools
    nodejs
    # CLIs
    gh
    git
    neofetch
    lazygit
    wifish
    # Editors
    neovim
    # GUIs
    firefox
    wezterm
    thunderbird
    obsidian
    wofi
    # Fonts
    recursive
  ];

  # Custom configs
  dotfiles = {
    wezterm.enable = true;
    hyprland.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Hyprland
  wayland.windowManager.hyprland.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
