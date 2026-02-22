{ ... }:
{
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    settings = {
      bar.customModules.storage.paths = [
        "/"
      ];
      theme.font.name = "FiraCode Nerd Font";
      theme.font.label = "FiraCode Nerd Font Medium";
      theme.bar.menus.enableShadow = false;
      scalingPriority = "gdk";
      theme.bar.floating = false;
      theme.bar.buttons.enableBorders = false;
      theme.bar.enableShadow = false;
      theme.font.weight = 600;
      bar.launcher.icon = "󱄅";
      theme.bar.menus.opacity = 100;
      theme.bar.menus.background = "#11111b";
      theme.bar.transparent = true;
      theme.bar.buttons.style = "split";
      theme.bar.buttons.background = "#11111b";
      theme.bar.buttons.monochrome = false;
      bar.layouts = {
        "*" = {
          left = [
            "dashboard"
            "workspaces"
            "media"
          ];
          middle = [
            "clock"
          ];
          right = [
            "volume"
            "network"
            "bluetooth"
            "battery"
            "hyprsunset"
            "kbinput"
            "systray"
            "notifications"
          ];
        };
      };
      menus.clock.time.hideSeconds = true;
      menus.clock.time.military = true;
      menus.clock.weather.location = "Porto";
      menus.clock.weather.unit = "metric";
      theme.bar.buttons.modules.kbLayout.enableBorder = false;
      theme.bar.buttons.modules.updates.enableBorder = false;
      bar.workspaces.monitorSpecific = true;
      theme.bar.buttons.workspaces.enableBorder = false;
      bar.workspaces.show_numbered = true;
      bar.workspaces.show_icons = false;
      bar.workspaces.workspaceMask = false;
      bar.workspaces.numbered_active_indicator = "highlight";
      bar.workspaces.ignored = -97;
      bar.media.show_active_only = true;
      menus.media.displayTime = false;
      theme.bar.buttons.modules.submap.enableBorder = false;
      bar.customModules.hyprsunset.label = false;
      bar.customModules.hyprsunset.temperature = "5000k";
    };
  };
}
