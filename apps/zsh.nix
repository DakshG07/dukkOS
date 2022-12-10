# ZSH stuff

{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true; # Enable home manager support for zsh
    enableCompletion = true;
    # Aliases
    shellAliases = {
      lg = "lazygit";
      nix-switch = "sudo nixos-rebuild switch";
      nix-update = "sudo nixos-rebuild --upgrade";
      home-switch = "home-manager switch -f $HOME/.nix/profiles/personal.nix -b backup";

      grep = "rg $@";
      ls = "exa --long --tree $@";
      cat = "bat $@";
    };

    initExtra = ''
      eval "$(starship init zsh)"
    '';
  };
}
