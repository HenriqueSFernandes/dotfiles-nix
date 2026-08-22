{ pkgs, ... }:
{
  home.packages = with pkgs; [
    manix
    pamixer
    playerctl
    networkmanagerapplet
    nodejs_24
  ];

  programs = {
    gh.enable = true;
  };
}
