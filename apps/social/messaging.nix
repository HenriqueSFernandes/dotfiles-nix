{ pkgs, ... }:
{
  home.packages = [
    pkgs.whatsapp-electron
    pkgs.telegram-desktop
  ];
}
