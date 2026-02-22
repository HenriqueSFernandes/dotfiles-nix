{
  description = "Home Manager configuration of ricky";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nixvim.url = "github:nix-community/nixvim/nixos-25.11";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };
  };

  outputs =
    { nixpkgs
    , home-manager
    , catppuccin
    , spicetify-nix
    , zen-browser
    , nixvim
    , silentSDDM
    , ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      # Function to create a NixOS config for a given hostname
      mkNixosConfig = { hostname, systemConfig }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs hostname; };
          modules = [
            systemConfig

            home-manager.nixosModules.home-manager
            silentSDDM.nixosModules.default
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs hostname; };
              home-manager.users.ricky = {
                imports = [
                  ./home.nix
                  catppuccin.homeModules.catppuccin
                  spicetify-nix.homeManagerModules.default
                ];
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        "ricky-laptop" = mkNixosConfig {
          hostname = "ricky-laptop";
          systemConfig = ./system/configuration.nix;
        };

        "ricky-desktop" = mkNixosConfig {
          hostname = "ricky-desktop";
          systemConfig = ./system/configuration.nix;
        };
      };
    };
}
