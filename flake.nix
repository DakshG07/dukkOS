{

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    newpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccinifier = {
      url = "github:DakshG07/catppuccinifier";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chill-mp = {
      url = "github:DakshG07/chill-mp";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    hyprland = {
      type = "git";
      url = "https://github.com/DakshG07/hyprland";
      submodules = true;
    };
  };

  description = "A very basic flake";

  outputs = { self, nixpkgs, newpkgs, home-manager, catppuccinifier, chill-mp, niri, hyprland, ... }@attrs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [ 
          niri.nixosModules.niri
          ./config/configuration.nix
          home-manager.nixosModules.home-manager
          ({config, ...}:{
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit (attrs) nixpkgs catppuccinifier chill-mp newpkgs hyprland;
              inherit system;
              flakePath = "/home/dukk/.nix";
            };
            home-manager.users.dukk = import ./home/home.nix;
            nixpkgs.config.allowUnfree = true;
          })
        ];
      };
    };
}
