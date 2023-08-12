{ config, pkgs, lib, hyprland, catppuccinifier, newpkgs, system, ... }:

let
  # Custom configs
  imports = [
    ../apps/wezterm.nix
    ../apps/hyprland.nix
    ../apps/nvim.nix
    ../apps/nushell.nix
    ../apps/helix.nix
    ../apps/zellij.nix
    ../apps/xmonad.nix
    ../apps/polybar.nix
    hyprland.homeManagerModules.default
  ];
  new = newpkgs.legacyPackages.${system};
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
    swww
    libnotify
    polkit_gnome
    bluez
    direnv
    wl-clipboard
    ffmpeg
    xdg-desktop-portal-gtk
    brightnessctl
    unzip
    xclip
    feh
    picom
    # Langs
    ghc            # Haskell
    cargo
    rustc
    rust-analyzer  # Rust
    nodejs         # Node
    zig            # Zig
    clang-tools    # C
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
    zellij
    hyperfine
    htop
    # Editors
    helix
    # GUIs
    firefox
    wezterm
    new.thunderbird
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
    vivaldi
    gparted
    obs-studio
    inkscape
    rofi
    polybar
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
    zellij.enable = true;
    xmonad.enable = true;
    polybar.enable = true;
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
