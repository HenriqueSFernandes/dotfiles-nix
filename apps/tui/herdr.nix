{ ... }:
{
  programs.herdr = {
    enable = true;
    settings = {
      onboarding = false;

      theme = {
        name = "catppuccin";
        auto_switch = false;
      };

      experimental = {
        pane_history = false;
        kitty_graphics = true;
      };

      keys = {
        navigate_workspace_up = "k";
        navigate_workspace_down = "j";
        navigate_pane_up = "up";
        navigate_pane_down = "down";

        previous_tab = "ctrl+super+h";
        next_tab = "ctrl+super+l";

        previous_workspace = "ctrl+super+k";
        next_workspace = "ctrl+super+j";

        previous_agent = "ctrl+alt+k";
        next_agent = "ctrl+alt+j";

        command = [
          {
            key = "ctrl+h";
            type = "plugin_action";
            command = "vim-herdr-navigation.left";
            description = "navigate left (vim/herdr)";
          }
          {
            key = "ctrl+j";
            type = "plugin_action";
            command = "vim-herdr-navigation.down";
            description = "navigate down (vim/herdr)";
          }
          {
            key = "ctrl+k";
            type = "plugin_action";
            command = "vim-herdr-navigation.up";
            description = "navigate up (vim/herdr)";
          }
          {
            key = "ctrl+l";
            type = "plugin_action";
            command = "vim-herdr-navigation.right";
            description = "navigate right (vim/herdr)";
          }
          {
            key = "ctrl+g";
            type = "popup";
            command = "lazygit";
            description = "lazygit";
            width = "90%";
            height = "90%";
          }
          {
            key = "prefix+p";
            type = "plugin_action";
            command = "jt.command-palette.open";
            description = "Command palette";
          }
        ];
      };

      ui = {
        show_agent_labels_on_pane_borders = true;
        agent_panel_sort = "priority";
        toast.delivery = "herdr";
      };
    };
  };
}
