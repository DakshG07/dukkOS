{ config, lib, flakePath, ...}:
with lib; let
  cfg = config.dotfiles.niri;
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  options.dotfiles.niri = {
    enable = mkEnableOption "Niri";
  };

  config = mkIf cfg.enable {
    xdg.configFile."niri" = {
      recursive = true;
      source = link "${flakePath}/dotfiles/niri";
    };
  };
}

