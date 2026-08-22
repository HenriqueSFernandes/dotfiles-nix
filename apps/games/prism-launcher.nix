{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.prismlauncher-cracked.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
