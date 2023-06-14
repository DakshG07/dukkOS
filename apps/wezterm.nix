{ config, lib, ...}:
with lib; let
  cfg = config.wezterm;
in {
  options.wezterm = {
    enable = mkEnableOption "Wezterm";
  };

  config = mkIf cfg.enable {
    home.file.".config/wezterm" = {
      recursive = true;
      source = ./wezterm;
    };
  };
}

