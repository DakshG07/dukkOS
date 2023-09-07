# Tools (CLI/GUI)
{ config, lib, pkgs, ... }:

with lib; let
  cfg = config.packages.tools;
in
{
  options.packages.tools = {
    enable = mkEnableOption "Haskell";
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
      zellij
      hyperfine
      htop
      maim
      gpg-tui
      playerctl
      # GUIs
      firefox
      new.thunderbird
      obsidian
      dunst
      blueman
      gnome.nautilus
      audacity
      vlc
      kdenlive
      new.vivaldi
      gparted
      obs-studio
      inkscape
      rofi
      xorg.libxcb
      xorg.xcbutil
      # Bonus editor
      helix
    ];
  };
}
