{ config, lib, flakePath, ...}:
with lib; let
  cfg = config.dotfiles.polybar;
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  options.dotfiles.polybar = {
    enable = mkEnableOption "Polybar";
  };

  config = mkIf cfg.enable {
    xdg.configFile."polybar" = {
      recursive = true;
      source = link "${flakePath}/dotfiles/polybar";
    };
  };
}

