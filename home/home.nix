{ config, pkgs, lib, hyprland, catppuccinifier, ... }:

let
  # Custom configs
  imports = [
    ../apps/wezterm.nix
    ../apps/hyprland.nix
    ../apps/nvim.nix
    ../apps/nushell.nix
    ../apps/helix.nix
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
    wl-clipboard
    ffmpeg
    xdg-desktop-portal-gtk
    brightnessctl
    # CLIs
    gh
    git
    neofetch
    lazygit
    just
    nushell
    zoxide
    fzf
    gnupg
    pinentry-qt
    pfetch
    catppuccinifier.packages.${pkgs.system}.cli
    thefuck
    # Editors
    helix
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
    audacity
    vlc
    kdenlive
    # Fonts
    recursive
  ];

  # Custom configs
  dotfiles = {
    wezterm.enable = true;
    hyprland.enable = true;
    nvim.enable = true;
    nushell.enable = true;
    helix.enable = true;
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

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    withNodeJs = true;
    
    extraPackages = with pkgs; [
      nodePackages."@astrojs/language-server"
      nodePackages.typescript
      nodePackages.typescript-language-server
    ];
  };

  # GTK
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Mauve-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
