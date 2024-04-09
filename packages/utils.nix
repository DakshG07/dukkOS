# Bloat (make stuff look nice)
{ config, lib, pkgs, ... }:

with lib; let
  cfg = config.packages.utils;
in
{
  options.packages.utils = {
    enable = mkEnableOption "Utils";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libnotify
      polkit_gnome
      direnv
      ffmpeg
      xdg-desktop-portal-gtk
      brightnessctl
      unzip
      xclip
      dconf
      localsend
    ];
  };
}
