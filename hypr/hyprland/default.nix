{ ... }:
{
  imports = [
    ./monitor.nix
    ./binds.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    settings = {
      config = {
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          col = {
            active_border = "rgba(89B4FBEE)";
          };
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
          kb_options = "caps:escape, grp:alt_space_toggle";
          numlock_by_default = true;
          follow_mouse = 1;
          touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
          };
          sensitivity = 0;
          # repeat_delay = 50
        };

        dwindle = {
          preserve_split = true;
          special_scale_factor = 0.8;
        };

        misc = {
          disable_hyprland_logo = true;
          enable_swallow = false;
          swallow_regex = "^(kitty)$";
        };
      };

      # Per-device pointer overrides. `name` is the libinput device name as
      # reported by `hyprctl devices` (lowercased, spaces -> dashes): the Nulea
      # M505 trackball is the mouse interface of its "Compx 2.4G Receiver" dongle.
      device = {
        name = "compx-2.4g-receiver-mouse";

        # "adaptive": libinput's speed-dependent profile - slow movements keep a
        # ~1:1 mapping, so fine positioning is precise rather than amplified,
        # while fast movements are accelerated. "flat" would disable acceleration.
        # Tuning levers:
        #   sensitivity = 0.0;   # -1.0..1.0; positive accelerates sooner and
        #                        # stronger, negative later and weaker
        #   accel_profile = "custom <step> <out0> <out1> ...";  # explicit curve:
        #                        point N is the output speed (device counts/ms)
        #                        for input speed N*step; interpolated between
        #                        points, extrapolated past the last one
        accel_profile = "adaptive";
      };
    };

    extraLuaFiles = {
      "00-vars" = ./lua/00-vars.lua;
      "10-animations" = ./lua/10-animations.lua;
      "20-autostart" = {
        content = ''
          -- Autostart.
          -- See https://wiki.hypr.land/Configuring/Basics/Autostart/

          hl.on("hyprland.start", function()
            hl.exec_cmd("swww-daemon")
            hl.exec_cmd("swww img ${../../wallpapers/cat_pacman.png} --transition-type simple")
            hl.exec_cmd("wl-paste --watch cliphist store")
            hl.exec_cmd("quickshell")
          end)
        '';
      };
      "25-rules" = ./lua/25-rules.lua;
      "30-binds" = ./lua/30-binds.lua;
    };
  };
}

