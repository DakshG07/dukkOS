{

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccinifier = {
      url = "github:DakshG07/catppuccinifier";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  description = "A very basic flake";

  outputs = { self, nixpkgs, home-manager, hyprland, catppuccinifier, ... }@attrs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [ 
          ./config/configuration.nix
          home-manager.nixosModules.home-manager
          ({config, ...}:{
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit (attrs) nixpkgs hyprland catppuccinifier;
              flakePath = "/home/dukk/.nix";
            };
            home-manager.users.dukk = import ./home/home.nix;
          })
          hyprland.nixosModules.default
          {
            programs.hyprland.enable = true;
            programs.hyprland.nvidiaPatches = true;
          }
        ];
      };
    };
}
