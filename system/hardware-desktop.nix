# Placeholder for desktop hardware configuration
# Generate this file by running 'nixos-generate-config' on your desktop
# and copying the hardware-configuration.nix to this file
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  # TODO: Add your desktop hardware configuration here
  # This is a minimal template. Replace with actual hardware config from your desktop.

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
