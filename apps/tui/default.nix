{ ... }:
{
  imports = [
    ./yazi.nix
    ./zellij.nix
  ];

  programs = {
    bluetuith.enable = true;
  };
}
