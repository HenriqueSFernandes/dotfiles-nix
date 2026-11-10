{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;

    # Allow Zed to keep writing runtime changes to ~/.config/zed/settings.json,
    # while Home Manager merges these declarative defaults on top.
    mutableUserSettings = true;

    # Keep nvim as the terminal/CLI default editor for now.
    defaultEditor = false;

    # Pre-install a minimal set useful for this repo.
    extensions = [
      "nix"
      "toml"
      "lua"
    ];

    # Language servers / tooling made available to Zed.
    extraPackages = with pkgs; [
      nixd
      lua-language-server
    ];

    userSettings = {
      vim_mode = true;

      theme = {
        mode = "system";
        dark = "Catppuccin Mocha";
        light = "Catppuccin Latte";
      };

      telemetry = {
        metrics = false;
        diagnostics = false;
      };

      autosave = "on_focus_change";

      # Nix language server configuration.
      languages = {
        Nix = {
          language_servers = [ "nixd" ];
          formatter = {
            external = {
              command = "nixfmt";
              arguments = [ "-" ];
            };
          };
        };
      };
    };
  };
}
