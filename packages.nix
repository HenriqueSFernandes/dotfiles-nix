{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    inputs.opencode-go-usage-analyzer.packages.${pkgs.system}.default
    inputs.nix-t3code.packages.${pkgs.system}.t3code-nightly
    (inputs.quickshell.packages.${pkgs.system}.default.withModules [
      pkgs.qt6.qtmultimedia
      pkgs.qt6.qtsvg
      pkgs.qt6.qtimageformats
      pkgs.qt6.qtmultimedia
      pkgs.qt6.qt5compat
    ])
    platformio
    brightnessctl
    jetbrains.datagrip
    openvpn
    rquickshare
    supertuxkart
    cloudflared
    deno
    deploy-rs
    hunspell
    hunspellDicts.en_US
    hunspellDicts.pt_PT
    hyprpicker
    wl-clipboard
    xdg-utils
    cliphist
    libreoffice-qt
    solaar
    thunar
    tldr
    wrangler
    sops
    google-chrome
  ];
}
