{ config, lib, flakePath, ...}:
with lib; let
  cfg = config.dotfiles.hyprland;
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  options.dotfiles.hyprland = {
    enable = mkEnableOption "Hyprland";
  };

  config = mkIf cfg.enable {
    xdg.configFile."hypr" = {
      recursive = true;
      source = link "${flakePath}/hyprland";
    };
  };
}
