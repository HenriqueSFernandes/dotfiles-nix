{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brightnessctl
    supertuxkart
    cloudflared
    deno
    deploy-rs
    hunspell
    hunspellDicts.en_US
    hunspellDicts.pt_PT
    hyprpicker
    libreoffice-qt
    solaar
    thunar
    tldr
    wrangler
    zulip
    sops
    google-chrome
  ];
}
