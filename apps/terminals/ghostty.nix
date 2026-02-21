{ ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "FiraCode Nerd Font";
      font-feature = [
        "calt"
        "liga"
        "dlig"
      ];
      font-size = 12;
      shell-integration-features = "cursor";
      cursor-style = "bar";
      mouse-hide-while-typing = true;
      keybind = "ctrl+backspace=text:\\x17";
    };
  };
}
