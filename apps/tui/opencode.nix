{ pkgs, config, ... }:
{
  home.file = {
    ".agents/skills".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.agents/skills";
  };

  home.packages = with pkgs; [
    poppler-utils
  ];

  programs.opencode = {
    enable = true;
    package = pkgs.opencode;
    settings = {
      "$schema" = "https://opencode.ai/config.json";
      model = "opencode-go/minimax-m3";
      mcp = {
        figma = {
          type = "local";
          command = [ "npx" "-y" "figma-developer-mcp" "--stdio" ];
          enabled = false;
          timeout = 15000;
        };
        chrome-devtools = {
          type = "local";
          command = [ "npx" "-y" "chrome-devtools-mcp" "--stdio" ];
          enabled = false;
          timeout = 60000;
        };
          type = "remote";
          enabled = false;
          timeout = 60000;
        };
      };
    };
  };
}
