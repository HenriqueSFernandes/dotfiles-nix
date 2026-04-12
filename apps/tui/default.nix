{ ... }:
{
  imports = [
    ./yazi.nix
    ./zellij.nix
    ./opencode.nix
  ];

  programs = {
    bluetuith.enable = true;
    k9s.enable = true;
    btop.enable = true;
    lazygit = {
      enable = true;
      enableFishIntegration = true;
    };
    lazydocker.enable = true;
  };
}
