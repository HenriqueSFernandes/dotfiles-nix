{
  description = "Home Manager configuration of ricky";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      catppuccin,
      spicetify-nix,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      homeConfigurations."ricky" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit spicetify-nix;
        };

        modules = [
          ./home.nix
          catppuccin.homeModules.catppuccin
          spicetify-nix.homeManagerModules.default
        ];
      };
    };
}
