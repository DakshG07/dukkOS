# Bloat (make stuff look nice)
{ config, lib, pkgs, ... }:

with lib; let
  cfg = config.packages.bloat;
in
{
  options.packages.bloat = {
    enable = mkEnableOption "Haskell";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      picom
      polybar
      neofetch
      pfetch
      eww
    ];
  };
}
