{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.prismlauncher-cracked.packages.${pkgs.system}.default
  ];
}
