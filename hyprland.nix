{
	wayland.windowManager.hyprland = {
		enable = true;
		settings = {
			"$mod" = "SUPER";
			"$terminal" = "ghostty";
			"$menu" = "rofi -show drun"; # TODO
				"$fileManager" = "thunar";

				monitor = [
				"eDP-1, 1920x1080@120, 1920x0, 1"
					"HDMI-A-1, 1920x1080@240, 0x0, 1"
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
    blur  = {
    };
		shadow = {
			enabled = true;
			range = 4;
			render_power = 3;
			color = "rgba(1a1a1aee)";
		};
};
			input = {
				kb_layout = "us, us";
				kb_variant = "intl, basic";
				kb_options = "caps:escape, grp:win_space_toggle";
				numlock_by_default=true;
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
    special_scale_factor=0.8;
};
gestures  = {
	gesture = "4, horizontal, workspace";
};
misc = {
    disable_hyprland_logo = true;
    enable_swallow = false;
    swallow_regex = "^(kitty)$";
};


			bind = [

# Basic Binds
				"$mod, Q, exec, $terminal"
					"$mod, C, killactive"
					"$mod, M, exit"
					"$mod, E, exec, $fileManager"
					"$mod, V, togglefloating"
					"$mod, R, exec, $menu"
					"$mod, O, pseudo"
					"$mod, n, togglesplit"

# Move focus with mod + hjkl
					"$mod, h, movefocus, l"
					"$mod, l, movefocus, r"
					"$mod, k, movefocus, u"
					"$mod, j, movefocus, d"

# Switch to workspace with mod + number
					"$mod, 1, workspace, 1"
					"$mod, 2, workspace, 2"
					"$mod, 3, workspace, 3"
					"$mod, 4, workspace, 4"
					"$mod, 5, workspace, 5"
					"$mod, 6, workspace, 6"
					"$mod, 7, workspace, 7"
					"$mod, 8, workspace, 8"
					"$mod, 9, workspace, 9"
					"$mod, 0, workspace, 10"

# Move window to workspace
					"$mod SHIFT, 1, movetoworkspacesilent, 1"
					"$mod SHIFT, 2, movetoworkspacesilent, 2"
					"$mod SHIFT, 3, movetoworkspacesilent, 3"
					"$mod SHIFT, 4, movetoworkspacesilent, 4"
					"$mod SHIFT, 5, movetoworkspacesilent, 5"
					"$mod SHIFT, 6, movetoworkspacesilent, 6"
					"$mod SHIFT, 7, movetoworkspacesilent, 7"
					"$mod SHIFT, 8, movetoworkspacesilent, 8"
					"$mod SHIFT, 9, movetoworkspacesilent, 9"
					"$mod SHIFT, 0, movetoworkspacesilent, 10"

# Resize window
					"$mod SHIFT, l, resizeactive, 20 0"
					"$mod SHIFT, h, resizeactive, -20 0"
					"$mod SHIFT, k, resizeactive, 0 -20"
					"$mod SHIFT, j, resizeactive, 0 20"

# Move windows
					"$mod SHIFT CTRL, h, movewindow, l"
					"$mod SHIFT CTRL, l, movewindow, r"
					"$mod SHIFT CTRL, k, movewindow, u"
					"$mod SHIFT CTRL, j, movewindow, d"


# Extra binds
					"$mod ALT, K, exec, shutdown now"
					"$mod, F, fullscreen, 1"
#"$mod, P, exec, /home/ricky/.config/rofi/bin/powermenu"
#"$mod SHIFT, E, exec, /home/ricky/.config/rofi/bin/emoji"
#"$mod SHIFT, V, exec, /home/ricky/.config/rofi/bin/rofi-virtualbox"
#"$mod, W, exec, /home/ricky/.config/rofi/bin/wallpaper-switcher"
#"$mod, B, exec, /home/ricky/.config/hypr/waybar_toggle.sh"
#"$mod ALT, L, exec, hyprlock"
#"$mt, exec, $HOME/.config/hypr/printscreen.sh --area"
#"$mod, Print, exec, $HOME/.config/hypr/printscreen.sh --window"
#"$mod SHIFT CTRL, Print, exec, $HOME/.config/hypr/printscreen.sh --screen"
#"$mod SHIFT, Print, exec, $HOME/.config/rofi/bin/screenshot "
#"$mod SHIFT, Y, exec, /home/ricky/Desktop/startup.sh"
#"$mod SHIFT, C, exec, hyprpicker -a"

# Special Workspaces
"$mod, S, togglespecialworkspace, magic"
"$mod SHIFT, S, movetoworkspace, special:magic"
"$mod, T, togglespecialworkspace, trash"
"$mod SHIFT, T, movetoworkspace, special:trash"

# Scroll Workspaces
"$mod, mouse_down, workspace, e+1"
"$mod, mouse_up, workspace, e-1"

# Move workspace to another monitor
"$mod SHIFT CTRL, 1, movecurrentworkspacetomonitor, HDMI-A-1"
"$mod SHIFT CTRL, 2, movecurrentworkspacetomonitor, eDP-1"




					];
					bindm = [
"$mod, mouse:272, movewindow"
"$mod, mouse:273, resizewindow"
					];
		};
	};
}
