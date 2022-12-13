{ config, pkgs, lib, ... }:
with lib; let
  cfg = config.starship;
in {
  options.starship = {
    enable = mkEnableOption "Starship config";

    userConfig = mkOption {
      default = null;
      description = "Starship config file";
      type = with types; nullOr path;
    };
  };
  config = mkIf cfg.enable {
    home = {
      file = {
	      ".config/starship.toml" = mkIf (cfg.userConfig != null) {
	        recursive = true;
	        source = cfg.userConfig;
        };
      };
    };
  };
}
