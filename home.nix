{ config, pkgs, ... }:

{
  home.username = "ricky";
  home.homeDirectory = "/home/ricky";

  home.stateVersion = "25.11";

  imports = [
    ./fish.nix
  ];

  home.packages = [
  ];

  home.file = {
  };

  home.sessionVariables = {
    DIRENV_LOG_FORMAT = "";
  };

  programs.home-manager.enable = true;

  programs = {

    eza = {
      enable = true;
      icons = "always";
      colors = "always";
      git = true;
    };

    fzf = {
      enable = true;
      defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
    };

    zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };

    starship = {
      enable = true;
      settings = builtins.fromTOML (builtins.readFile ./starship.toml);
			enableTransience = true;
    };
  };

  catppuccin = {
    fish.enable = true;
    fish.flavor = "mocha";

    fzf.enable = true;
    fzf.accent = "blue";
    fzf.flavor = "mocha";

    eza.enable = true;
    eza.accent = "blue";
    eza.flavor = "mocha";

  };
}
