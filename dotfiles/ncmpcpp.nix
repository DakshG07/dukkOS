{ config, lib, flakePath, ...}:
with lib; let
  cfg = config.dotfiles.ncmpcpp;
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  options.dotfiles.ncmpcpp = {
    enable = mkEnableOption "Ncmpcpp";
  };

  config = mkIf cfg.enable {
    xdg.configFile."ncmpcpp" = {
      recursive = true;
      source = link "${flakePath}/dotfiles/ncmpcpp";
    };
  };
}

