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
  ];
}
