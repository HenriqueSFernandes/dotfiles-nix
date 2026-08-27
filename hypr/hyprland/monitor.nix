{ hostname, ... }:
let
  monitors =
    if hostname == "ricky-laptop" then ''
      hl.monitor({ output = "eDP-1", mode = "1920x1080@120", position = "1920x0", scale = 1 })
      hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@240", position = "0x0", scale = 1 })
    ''
    else if hostname == "ricky-desktop" then ''
      hl.monitor({ output = "DP-2", mode = "1920x1080@240", position = "1920x0", scale = 1 })
      hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "0x0", scale = 1 })
    ''
    else ''
      hl.monitor({ output = "eDP-1", mode = "1920x1080@120", position = "1920x0", scale = 1 })
    '';
in
{
  wayland.windowManager.hyprland.extraLuaFiles."40-monitors" = monitors;
}
