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
      ide = {
        layout =
          {
            _children = [
              {
                default_tab_template = {
                  _children = [
                    {
                      pane = {
                        size = 1;
                        borderless = true;
                        plugin = {
                          location = "zellij:tab-bar";
                        };
                      };
                    }
                    { "children" = { }; }
                    # {
                    #   pane = {
                    #     size = 2;
                    #     borderless = true;
                    #     plugin = {
                    #       location = "zellij:status-bar";
                    #     };
                    #   };
                    # }
                  ];
                };
              }
              {
                tab = {
                  _props = {
                    name = "Neovim";
                    focus = true;
                  };
                  _children = [
                    {
                      pane = {
                        command = "nvim";
                        args = ".";
                      };
                    }
                  ];
                };
              }
              {
                tab = {
                  _props = {
                    name = "Terminals";
                    focus = false;
                    split_direction = "vertical";
                  };
                  _children = [
                    {
                      pane = { };
                    }
                    {
                      pane = { };
                    }
                  ];
                };

              }
              {
                tab = {
                  _props = {
                    name = "Opencode";
                    focus = false;
                  };
                  _children = [
                    {
                      pane = {
                        command = "opencode";
                      };
                    }
                  ];
                };
              }
            ];
          };
      };
    };
  };
}
