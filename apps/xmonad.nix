{ config, lib, flakePath, ...}:
with lib; let
  cfg = config.dotfiles.xmonad;
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  options.dotfiles.xmonad = {
    enable = mkEnableOption "XMonad";
  };

  config = mkIf cfg.enable {
    home.file.".xmonad" = {
      source = link "${flakePath}/apps/xmonad";
      recursive = true;
    };
  };
}

