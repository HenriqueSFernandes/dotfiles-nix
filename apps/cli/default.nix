{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gemini-cli
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
