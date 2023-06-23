{ config, lib, flakePath, ...}:
with lib; let
  cfg = config.dotfiles.nushell;
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  options.dotfiles.nushell = {
    enable = mkEnableOption "Nushell";
  };

  config = mkIf cfg.enable {
    # Delete default Nushell-generated config
    xdg.configFile."nushell/config.nu".enable = false;
    xdg.configFile."nushell/env.nu".enable = false;
    # Load in our config
    xdg.configFile."nushell" = {
      source = link "${flakePath}/apps/nushell";
      recursive = true;
    };
  };
}
