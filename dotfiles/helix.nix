{ config, lib, flakePath, ...}:
with lib; let
  cfg = config.dotfiles.helix;
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  options.dotfiles.helix = {
    enable = mkEnableOption "Helix";
  };

  config = mkIf cfg.enable {
    xdg.configFile."helix" = {
      recursive = true;
      source = link "${flakePath}/dotfiles/helix";
    };
  };
}

