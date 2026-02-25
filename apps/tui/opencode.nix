{ pkgs, ... }:
{
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
