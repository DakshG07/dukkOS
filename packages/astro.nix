{ config, pkgs, lib, ... }:
with lib; let
  cfg = config.astronvim;
  astronvim = pkgs.fetchFromGithub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "176265812355a53559497c0f0ada7ab62a2d1ba8";
    sha256 = "6a1f78fecb99bc19daef8282f96274dc64f9fa2832185a09ef81d85c68e2b845";
  };
  packer = pkgs.fetchFromGithub {
    owner = "wbthomason";
    repo = "packer.nvim";
    rev = "64ae65fea395d8dc461e3884688f340dd43950ba";
    sha256 = "dbac4dc9c8c18b3b64e3e520ee0c7249ab993755d4f23ee4d2c8915988ab9dae";
  };
in {
  options.astronvim = {
    enable = mkOption {
      default = false;
      description = "Enables AstroNvim";
      type = types.bool;
    };

    userConfig = mkOption {
      default = null;
      description = "AstroNvim user config directory"
      type = with types; nullOr path;
    };
  };
  config = mkIf (cfg.enable) {
    home = {
      file = {
        ".local/share/nvim/site/pack/packer/start/packer.nvim" = {
	  recursive = true;
	  source = packer;
	};
        ".config/nvim" = {
	  recursive = true;
	  source = astronvim;
        };
	".config/nvim/lua/user" = mkIf (cfg.userConfig != null) {
	  recursive = true;
	  source = cfg.userConfig;
        };
      };
    };
  };
}
