{ ... }:
{
  services.wayle = {
    enable = true;
    # systemd.enable = true;
    autoInstallDependencies = true;
    settings = {
      bar = {
        layout = [
          {
            center = [ "clock" ];
            left = [
              "dashboard"
              "hyprland-workspaces"
              "media"
              "keyboard-input"
            ];
            monitor = "*";
            right = [
              "battery"
              "bluetooth"
              "network"
              "microphone"
              "volume"
              "notifications"
            ];
            show = true;
          }
        ];
      };
      menus = {
        clock = {
          time = {
            hideSeconds = true;
            military = true;
          };
          weather = {
            location = "Porto";
            unit = "metric";
          };
        };
        media = {
          displayTime = false;
        };
      };
      modules = {
        bluetooth = {
          label-show = false;
        };
        dashboard = {
          icon-bg-color = "status-info";
        };
        hyprland-workspaces = {
          monitor-specific = false;
          show-special = false;
        };
        media = {
          border-color = "green";
          icon-bg-color = "green";
          label-color = "green";
        };
        network = {
          label-show = false;
        };
        notifications = {
          label-show = false;
        };
      };
      scalingPriority = "gdk";
      styling = {
        palette = {
          blue = "#74c7ec";
          elevated = "#1e1e2e";
          fg = "#cdd6f4";
          fg-muted = "#bac2de";
          green = "#a6e3a1";
          primary = "#b4befe";
          red = "#f38ba8";
          surface = "#1e1e2e";
          yellow = "#f9e2af";
        };
      };
      theme = {
        bar = {
          buttons = {
            background = "#11111b";
            enableBorders = false;
            modules = {
              kbLayout = {
                enableBorder = false;
              };
              submap = {
                enableBorder = false;
              };
              updates = {
                enableBorder = false;
              };
            };
            monochrome = false;
            style = "split";
            workspaces = {
              enableBorder = false;
            };
          };
          enableShadow = false;
          floating = false;
          menus = {
            background = "#11111b";
            enableShadow = false;
            opacity = 100;
          };
          outer_spacing = "0.3em";
          transparent = true;
        };
        font = {
          label = "FiraCode Nerd Font Medium";
          name = "FiraCode Nerd Font";
          weight = 600;
        };
      };
    };
  };
}
