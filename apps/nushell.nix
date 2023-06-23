{ config, lib, ...}:
with lib; let
  cfg = config.dotfiles.nushell;
in {
  options.dotfiles.nushell = {
    enable = mkEnableOption "Nushell";
  };

  config = mkIf cfg.enable {
    home.file.".config/nushell" = {
      recursive = true;
      source = ./nushell;
    };
  };
}
