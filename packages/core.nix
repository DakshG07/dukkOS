# "Core" packages, don't recommend disabling these
{ config, lib, pkgs, ... }:

with lib; let
  cfg = config.packages.core;
in
{
  options.packages.core = {
    enable = mkEnableOption "Haskell";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Utils
      bluez     # Bluetooth
      feh       # Wallpaper
      # CLIs
      git       # Git (duh)
      nushell   # Shell
      # GUIs
      wezterm   # Terminal
      # Font
      recursive # Font (not too essential, but used everywhere, so...)
    ];
  };
}
