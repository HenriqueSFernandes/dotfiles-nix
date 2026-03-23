{ hostname, ... }:
{
  wayland.windowManager.hyprland.settings.monitor =
    if hostname == "ricky-laptop" then [
      # "eDP-1, 1920x1080@120, 1920x0, 1"
      # "HDMI-A-1, 1920x1080@240, 0x0, 1"
      # "eDP-1, 1920x1080@120, 0x1080, 1"
      # "HDMI-A-1, 1920x1080@240, 0x0, 1"
      "eDP-1, 1920x1080@120, 0x0, 1"
      "HDMI-A-1, 1920x1080@240, 1920x0, 1"
    ]
    else if hostname == "ricky-desktop" then [
      "DP-2, 1920x1080@240, 1920x0, 1"
      "HDMI-A-1, 1920x1080@60, 0x0, 1"
    ]
    else [
      "eDP-1, 1920x1080@120, 1920x0, 1"
    ];
}
