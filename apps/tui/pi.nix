{ config, ... }:
{
  programs.pi.coding-agent = {
    enable = true;
    rules = ./rules.md;
    settings = {
      theme = "catppuccin-mocha";
      packages = [
        "npm:pi-mcp-adapter"
        "npm:pi-web-access"
        "npm:@juicesharp/rpiv-ask-user-question"
        "npm:pi-lens"
        "npm:pi-hermes-memory"
        "npm:pi-nvim"
        "npm:@juicesharp/rpiv-todo"
        "npm:@juicesharp/rpiv-btw"
        "npm:pi-execution-time"
      ];
    };
  };

  home.file."${config.programs.pi-coding-agent.configDir}/themes/catppuccin-mocha.json".source =
    ./pi-catppuccin-mocha.json;
}
