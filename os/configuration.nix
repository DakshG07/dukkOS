{ lib, pkgs, config, modulesPath, ... }:

with lib;
let
  nixos-wsl = import ./nixos-wsl;
in
{
  imports = [
    "${modulesPath}/profiles/minimal.nix"

    nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    automountPath = "/mnt";
    defaultUser = "dukk";
    startMenuLaunchers = false;

    # Enable native Docker support
    # docker-native.enable = true;

    # Enable integration with Docker Desktop (needs to be installed)
    # docker-desktop.enable = true;

  };

  users.users.dukk = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel" # sudo
    ];
    shell = pkgs.zsh;
  };

  environment.shells = with pkgs; [
    zsh
  ];

  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "22.05";
  environment.systemPackages = with pkgs; [
    neovim
    wget
    neofetch
    git
    zig
    cargo
    nodejs
    lazygit
    zsh
    starship
    bat
    home-manager
  ];
}
