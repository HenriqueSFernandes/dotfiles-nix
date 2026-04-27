{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    inputs.opencode-go-usage-analyzer.packages.${pkgs.system}.default
    brightnessctl
    rquickshare
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
