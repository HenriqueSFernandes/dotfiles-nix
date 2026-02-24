{ ... }:
{
  imports = [
    ./monitor.nix
    ./binds.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      "$menu" = "rofi -show drun";
      "$fileManager" = "thunar";

      exec-once = [
        "swww-daemon"
        "swww img ${../../wallpapers/cat_pacman.png} --transition-type simple"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(89B4FBEE)";
        layout = "dwindle";
      };
      decoration = {
        rounding = 10;
        blur = { };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };
      cursor = {
        inactive_timeout = 5;
        no_hardware_cursors = 1;
      };
      input = {
        kb_layout = "us, us";
        kb_variant = "basic, intl";
        kb_options = "caps:escape, grp:win_space_toggle";
        numlock_by_default = true;
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
        sensitivity = 0;
        #repeat_delay = 50
      };
      animations = {
        enabled = true;
        bezier = [
          "overshot, 0.05, 0.9, 0.1, 1.05"
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
        ];
        animation = [

          "windows, 1, 5, overshot, slide"
          "windowsOut, 1, 4, smoothOut, slide"
          "windowsMove, 1, 4, default"
          "border, 1, 10, default"
          "fade, 1, 10, smoothIn"
          "fadeDim, 1, 10, smoothIn"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        special_scale_factor = 0.8;
      };
      gestures = {
        gesture = "4, horizontal, workspace";
      };
      misc = {
        disable_hyprland_logo = true;
        enable_swallow = false;
        swallow_regex = "^(kitty)$";
      };
    };
  };
}

