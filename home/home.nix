{ config, pkgs, lib, hyprland, ... }:

let
  # Custom configs
  imports = [
    ../apps/wezterm.nix
    ../apps/hyprland.nix
    ../apps/nvim.nix
    ../apps/nushell.nix
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
    swww
    zig
    libnotify
    polkit_gnome
    bluez
    direnv
    # CLIs
    gh
    git
    neofetch
    lazygit
    just
    nushell
    zoxide
    fzf
    # Editors
    neovim
    # GUIs
    firefox
    wezterm
    thunderbird
    obsidian
    wofi
    wdisplays
    eww-wayland
    dunst
    swaylock
    blueman
    gnome.nautilus
    grim
    slurp
    # Fonts
    recursive
  ];

  # Custom configs
  dotfiles = {
    wezterm.enable = true;
    hyprland.enable = true;
    nvim.enable = true;
    nushell.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Hyprland
  wayland.windowManager.hyprland.enable = true;

  # Nushell
  programs.nushell.enable = true;

  # Direnv
  programs.direnv.enable = true;

  # GTK
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Compact-Mauve-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = "macchiato";
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
