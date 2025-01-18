# Bloat (make stuff look nice)
{ config, lib, pkgs, ... }:

with lib; let
  cfg = config.packages.bloat;
in
{
  options.packages.bloat = {
    enable = mkEnableOption "Bloat";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      picom
      polybar
      neofetch
      pfetch
      cmatrix
      cbonsai
      cava
      cider
      cloudflare-warp
      zoom-us
      ncmpcpp
      miniplayer
      libreoffice
      vesktop
      iosevka-comfy.comfy
      iosevka-comfy.comfy-duo
      new.figma-linux
      new.papermc
    ];
  };
}
