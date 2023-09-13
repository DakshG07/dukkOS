{ config, lib, flakePath, ...}:
with lib; let
  cfg = config.dotfiles.cava;
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  options.dotfiles.cava = {
    enable = mkEnableOption "Cava";
  };

  config = mkIf cfg.enable {
    xdg.configFile."cava" = {
      recursive = true;
      source = link "${flakePath}/dotfiles/cava";
    };
  };
}

