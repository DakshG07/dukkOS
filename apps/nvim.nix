{ config, lib, ...}:
with lib; let
  cfg = config.dotfiles.nvim;
in {
  options.dotfiles.nvim = {
    enable = mkEnableOption "Nvim";
  };

  config = mkIf cfg.enable {
    home.file.".config/nvim/" = {
      recursive = true;
      source = ./nvim;
    };
  };
}
