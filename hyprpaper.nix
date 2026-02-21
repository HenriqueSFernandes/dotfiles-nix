{ config, ... }:

let
  selectedWallpaper = wallpapers/cat_pacman.png;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;

      preload = [
        "${selectedWallpaper}"
      ];

      wallpaper = [
        ",${selectedWallpaper}"
      ];
    };
  };
}
