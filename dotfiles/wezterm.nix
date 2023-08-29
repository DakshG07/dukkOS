{ config, lib, flakePath, ...}:
with lib; let
  cfg = config.dotfiles.wezterm;
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  options.dotfiles.wezterm = {
    enable = mkEnableOption "Wezterm";
  };

  config = mkIf cfg.enable {
    xdg.configFile."wezterm" = {
      recursive = true;
      source = link "${flakePath}/dotfiles/wezterm";
    };
  };
}

