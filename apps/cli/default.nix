{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gemini-cli
    manix
    pamixer
    playerctl
    networkmanagerapplet
  ];

  programs = {
    gh.enable = true;
  };
}
