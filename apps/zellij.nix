{ config, lib, flakePath, ...}:
with lib; let
  cfg = config.dotfiles.zellij;
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  options.dotfiles.zellij = {
    enable = mkEnableOption "Zellij";
  };

  config = mkIf cfg.enable {
    xdg.configFile."zellij" = {
      recursive = true;
      source = link "${flakePath}/apps/zellij";
    };
  };
}

