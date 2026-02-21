{ config, pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    settings = {
      pane_frames = false;
      show_startup_tips = false;
      keybinds = {
        normal = {
          "unbind \"Ctrl p\"" = { };
          "unbind \"Ctrl h\"" = { };
          "bind \"Ctrl a\"" = {
            SwitchToMode = "Pane";
          };
        }
        // (builtins.listToAttrs (
          map
            (i: {
              name = "bind \"Ctrl ${toString i}\"";
              value = {
                GoToTab = i;
              };
            })
            [
              1
              2
              3
              4
              5
              6
              7
              8
              9
            ]
        ));
        pane = {
          "bind \"Ctrl a\"" = {
            SwitchToMode = "Normal";
          };
        };
      };
    };
    layouts = {
      uni = {
        layout = {
          cwd = "~/Desktop/NIAEFEUP/uni/packages/uni_app";
          default_tab_template = {
            children = [ ];
            pane = [
              {
                size = 1;
                borderless = true;
                plugin.location = "zellij:tab-bar";
              }
              {
                size = 1;
                borderless = true;
                plugin.location = "zellij:status-bar";
              }
            ];
          };

          tab = [
            {
              name = "editor";
              split_direction = "vertical";
              pane = {
                command = "nvim";
                args = [ "." ];
              };
            }
            {
              name = "flutter";
              split_direction = "vertical";
              pane = [
                { }
                { }
              ];
            }
            {
              name = "files";
              pane = {
                command = "yazi";
              };
            }
          ];
        };
      };
    };
  };
}
