{ pkgs, config, ... }:
{
  home.file = {
    ".agents/skills".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.agents/skills";
  };

  programs.opencode = {
    enable = true;
    package = pkgs.opencode;
    settings = {
      provider = {
        anthropic = {
          options = {
            timeout = 600000;
            setCacheKey = true;
          };
        };
      };
    };
  };
}
