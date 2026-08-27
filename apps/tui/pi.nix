{ config, ... }:
{
  programs.pi.coding-agent = {
    enable = true;
    rules = ./rules.md;
    settings = {
      theme = "catppuccin-mocha";
    };
  };

  home.file."${config.programs.pi-coding-agent.configDir}/themes/catppuccin-mocha.json".source =
    ./pi-catppuccin-mocha.json;
}
