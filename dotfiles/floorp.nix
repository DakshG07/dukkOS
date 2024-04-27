{ config, lib, flakePath, ...}:
with lib; let
  cfg = config.dotfiles.floorp;
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  options.dotfiles.floorp = {
    enable = mkEnableOption "Zellij";
  };

  config = mkIf cfg.enable {
    home.file.".floorp/3lljaaf2.default/chrome" = {
      recursive = true;
      source = link "${flakePath}/dotfiles/floorp";
    };
  };
}

