{ config, pkgs, ... }:

{
  home.username = "ricky";
  home.homeDirectory = "/home/ricky";

  home.stateVersion = "25.11";

  imports = [
    ./fish.nix
    ./yazi.nix
    ./catppuccin.nix
  ];

  home.packages = [
    pkgs.manix
    pkgs.gemini-cli
  ];

  home.file = {
    ".agents/skills".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/.agents/skills";
  };

  home.sessionVariables = {
    DIRENV_LOG_FORMAT = "";
  };

  programs.home-manager.enable = true;

  programs = {

    ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        font-family = "FiraCode Nerd Font";
        font-size = 12;
        font-feature = [
          "calt"
          "liga"
          "dlig"
        ];
        shell-integration-features = "cursor";
        cursor-style = "bar";
        mouse-hide-while-typing = true;
      };
    };

    opencode = {
      enable = true;
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
      icons = "always";
      colors = "always";
      git = true;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [
        "--cmd cd"
      ];
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
      silent = true;
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = fromTOML (builtins.readFile ./starship.toml);
      enableTransience = true;
    };
  };
}
