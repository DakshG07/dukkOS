{ config, lib, ...}:
with lib; let
  cfg = config.dotfiles.wezterm;
in {
  options.dotfiles.wezterm = {
    enable = mkEnableOption "Wezterm";
  };

  config = mkIf cfg.enable {
    home.file.".config/wezterm" = {
      recursive = true;
      source = ./wezterm;
    };
  };
}

