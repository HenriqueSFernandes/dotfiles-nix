{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brightnessctl
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
  ];
}
