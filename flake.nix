{
  description = "Home Manager configuration of ricky";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-zotero.url = "github:nixos/nixpkgs/e158d9ed9b51c98974c5e66e1ba1c9e0255fecaa";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
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
    pi.url = "github:lukasl-dev/pi.nix";
    hex.url = "github:anomalyco/hex";
  };

  outputs = inputs@{ nixpkgs, home-manager, catppuccin, spicetify-nix, silentSDDM, sops-nix, pi, hex, ... }:
    let
      system = "x86_64-linux";
      overlay = final: prev: {
        anker-launcher = final.callPackage ./pkgs/anker-launcher { };

        # Upstream hex flake currently has a stale output hash for its `rune`
        # git dependency. Override cargoDeps with the correct hash until the
        # upstream flake is fixed.
        hex = inputs.hex.packages.${system}.hex.overrideAttrs (old: {
          cargoDeps = final.rustPlatform.importCargoLock {
            lockFile = "${inputs.hex.packages.${system}.hex.src}/Cargo.lock";
            outputHashes = {
              "transcribe-rs-0.3.11" = "sha256-MJJiug3LfbKsuHcL2+LJk95+j5kk/MWzb5ihdBlHLmE=";
              "rune-0.0.1" = "sha256-FGgfrqN9OaygnVhtE2K0C85wq3aicF+ep2F10aKVd/E=";
              "transcribe-cpp-sys-0.4.1" = "sha256-BAc2qKUMBZ5D6+Bq12NaZ1+ntWxHv95TYcAMTt3a5X8=";
            };
          };
        });
      };
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ overlay ];
      };
    in
    {
      packages.${system} = {
        anker-launcher = pkgs.anker-launcher;
        default = pkgs.anker-launcher;
      };

      nixosConfigurations = {
        "ricky-laptop" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            { nixpkgs.overlays = [ overlay ]; }
            ./system/hardware-laptop.nix
            ./system/configuration.nix
            home-manager.nixosModules.home-manager
            silentSDDM.nixosModules.default
            sops-nix.nixosModules.sops
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.ricky = {
                imports = [
                  ./home.nix
                  catppuccin.homeModules.catppuccin
                  spicetify-nix.homeManagerModules.default
                  pi.homeModules.default
                ];
              };
            }
          ];
        };
      };
    };
}
