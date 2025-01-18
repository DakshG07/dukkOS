# Tools (CLI/GUI)
{ config, lib, pkgs, ... }:

with lib; let
  cfg = config.packages.tools;
in
{
  options.packages.tools = {
    enable = mkEnableOption "Tools";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # CLIs
      gh
      lazygit
      just
      zoxide
      fzf
      gnupg
      pinentry-qt
      htop
      maim
      gpg-tui
      playerctl
      # GUIs
      new.firefox
      new.thunderbird
      obsidian
      dunst
      blueman
      gnome.nautilus
      #audacity
      #vlc
      kdePackages.kdenlive
      #blender
      #new.vivaldi
      #gparted
      #obs-studio
      #inkscape
      rofi
      xorg.libxcb
      xorg.xcbutil
      glaxnimate
      cmake
      gnumake
      #ninja
      #tldr
      new.floorp
      zellij
      docker
      bottles
      autorandr
      yazi
      mpc-cli
      pavucontrol
      easyeffects
      wdisplays
      gparted
      arduino-ide
      # Bonus editor
      helix
    ];
  };
}
