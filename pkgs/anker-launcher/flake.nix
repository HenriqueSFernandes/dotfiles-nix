{
  description = "Anker Launcher — desktop client for AnkerGames (AppImage repack)";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      packages.${system} = {
        anker-launcher = pkgs.callPackage ./default.nix { };
        default = pkgs.callPackage ./default.nix { };
      };
    };
}
