{ config, lib, ...}:
with lib; let
  cfg = config.dotfiles.hyprland;
in {
  options.dotfiles.hyprland = {
    enable = mkEnableOption "Hyprland";
  };

  config = mkIf cfg.enable {
    home.file.".config/hypr/" = {
      recursive = true;
      source = ./hyprland;
    };
  };
}
