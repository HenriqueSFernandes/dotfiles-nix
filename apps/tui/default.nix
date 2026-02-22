{ ... }:
{
  imports = [
    ./yazi.nix
    ./zellij.nix
  ];

  programs = {
    bluetuith.enable = true;
    btop.enable = true;
    opencode.enable = true;
    lazygit = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
