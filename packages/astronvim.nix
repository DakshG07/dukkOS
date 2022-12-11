{ config, pkgs, lib, ... }:
with lib; let
  cfg = config.astronvim;
  astronvim = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "176265812355a53559497c0f0ada7ab62a2d1ba8";
    sha256 = "sha256-uiEyCC0a16h9qqcluKp2TvADQd2yfdFMuBW2hqA2ZAw=";
  };
  packer = pkgs.fetchFromGitHub {
    owner = "wbthomason";
    repo = "packer.nvim";
    rev = "64ae65fea395d8dc461e3884688f340dd43950ba";
    sha256 = "sha256-ra9qlUD0x1S3Q4WFN6f56FscHR/ZmTRDQ9yg+ETt3oA=";
  };
in {
  options.astronvim = {
    enable = mkEnableOption "AstroNvim";

    userConfig = mkOption {
      default = null;
      description = "AstroNvim user config directory";
      type = with types; nullOr path;
    };
  };
  config = mkIf cfg.enable {
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
