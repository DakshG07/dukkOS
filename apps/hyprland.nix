{ config, lib, flakePath, ...}:
with lib; let
  cfg = config.dotfiles.hyprland;
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  options.dotfiles.hyprland = {
    enable = mkEnableOption "Hyprland";
  };

  config = mkIf cfg.enable {
    # Delete default Hyprland-generated config
    xdg.configFile."hypr/hyprland.conf".enable = false;
    # Load in our config
    xdg.configFile."hypr" = {
      source = link "${flakePath}/apps/hyprland";
      recursive = true;
    };
  };
}
