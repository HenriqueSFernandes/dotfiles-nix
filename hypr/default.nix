{ ... }:
{
  imports = [
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpanel.nix
  ];

  services.hyprsunset.enable = true;
}
