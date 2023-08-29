{ config, lib, flakePath, ...}:
with lib; let
  cfg = config.dotfiles.nvim;
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  options.dotfiles.nvim = {
    enable = mkEnableOption "Nvim";
  };

  config = mkIf cfg.enable {
    # Load in config
    xdg.configFile."nvim" = {
      source = link "${flakePath}/dotfiles/nvim";
      recursive = true;
    };
  };
}
