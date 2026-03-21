{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wrangler
    brightnessctl
    hyprpicker
    cloudflared
    thunar
    zulip
    deno
    libreoffice-qt
    hunspell
    hunspellDicts.pt_PT
    hunspellDicts.en_US
    deploy-rs
    tldr
  ];
}
