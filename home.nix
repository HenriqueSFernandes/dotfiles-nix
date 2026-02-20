{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.username = "ricky";
  home.homeDirectory = "/home/ricky";

  home.stateVersion = "25.11";

  imports = [
    ./fish.nix
    ./yazi.nix
    ./catppuccin.nix
    ./zellij.nix
    ./hyprland.nix
    ./nvim.nix
    inputs.zen-browser.homeModules.beta
    inputs.nixvim.homeModules.nixvim
  ];

  home.packages = [
    pkgs.manix
    pkgs.gemini-cli
    pkgs.thunar
  ];

  home.file = {
    ".agents/skills".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/.agents/skills";
  };

  home.sessionVariables = {
    DIRENV_LOG_FORMAT = "";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  programs.home-manager.enable = true;

  programs = {
    rofi = {
      enable = true;
    };

    lazygit = {
      enable = true;
      enableFishIntegration = true;

    };

    hyprpanel = {
      enable = true;
      systemd.enable = true;
    };

    bat = {
      enable = true;
      config = {
        style = "grid,header";
      };
    };

    zen-browser = {
      enable = true;
      suppressXdgMigrationWarning = true;
    };

    git = {
      enable = true;
      settings = {
        user = {
          name = "HenriqueSFernandes";
          email = "henriquesardofernandes@gmail.com";
        };
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
    };

    ghostty = {
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
      };
    };

    spotify-player = {
      enable = true;
      settings = {
        audio_backend = "pulseaudio-backend";
        device = {
          name = "Laptop";
          device_type = "computer";
          volume = 80;
          bitrate = 320;
          audio_cache = true;
        };
      };
    };

    spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        enable = true;
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";
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

    fd = {
      enable = true;
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

    ripgrep.enable = true;
  };
}
