{ config, pkgs, lib, catppuccinifier, newpkgs, system, ... }:

let
  imports = [
    # Custom dotfiles
    ../dotfiles/wezterm.nix
    ../dotfiles/nvim.nix
    ../dotfiles/nushell.nix
    ../dotfiles/helix.nix
    ../dotfiles/zellij.nix
    ../dotfiles/xmonad.nix
    ../dotfiles/polybar.nix
    ../dotfiles/cava.nix
    ../dotfiles/floorp.nix
    # Packages
    ../packages/core.nix
    ../packages/tools.nix
    ../packages/utils.nix
    ../packages/langs.nix
    ../packages/bloat.nix
  ];
  new = newpkgs.legacyPackages.${system};
in
{
  inherit imports;
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dukk";
  home.homeDirectory = "/home/dukk";

  home.stateVersion = "23.05";

  # Custom configs
  dotfiles = {
    wezterm.enable = true;
    nvim.enable = true;
    nushell.enable = true;
    helix.enable = true;
    zellij.enable = true;
    xmonad.enable = true;
    polybar.enable = true;
    cava.enable = true;
    floorp.enable = true;
  };

  # Not gonna make an option for this so I'll just put it here
  home.packages = [
    catppuccinifier.packages.${pkgs.system}.cli
  ];

  # Maybe now gpg-agent will work
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  # Packages
  packages = {
    core.enable = true;
    tools.enable = true;
    utils.enable = true;
    bloat.enable = true;
    langs = {
      haskell.enable = true;
      rust.enable = true;
      node.enable = true;
      zig.enable = true;
      c.enable = true;
      python.enable = true;
      java.enable = true;
      flutter.enable = false;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Nushell
  programs.nushell.enable = true;

  # Direnv
  programs.direnv.enable = true;

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    withNodeJs = true;
    
    extraPackages = with pkgs; [
      nodePackages."@astrojs/language-server"
      nodePackages.typescript
      nodePackages.typescript-language-server
    ];
  };

  # GTK
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Mauve-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
