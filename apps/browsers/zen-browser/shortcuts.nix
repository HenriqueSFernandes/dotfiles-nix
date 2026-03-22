{ config, ... }:
{
  programs.zen-browser.profiles.${config.home.username}.keyboardShortcuts = [
    {
      id = "zen-split-view-horizontal";
      key = "1";
      modifiers = {
        control = true;
      };
    }
    {
      id = "zen-split-view-vertical";
      key = "2";
      modifiers = {
        control = true;
      };
    }
    {
      id = "zen-split-view-grid";
      key = "3";
      modifiers = {
        control = true;
      };
    }
    {
      id = "zen-split-view-unsplit";
      key = "4";
      modifiers = {
        control = true;
      };
    }
    {

      id = "zen-compact-mode-toggle";
      key = "c";
      modifiers = {
        control = true;
        alt = true;
      };
    }
  ] ++ map
    (x: {
      id = "zen-workspace-switch-${toString x}";
      key = "${toString x}";
      modifiers = {
        control = true;
        alt = true;
      };
    })
    [ 1 2 3 4 5 6 7 8 9 ];
}
