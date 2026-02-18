{
  config,
  pkgs,
  spicetify-nix,
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
  ];

  home.packages = [
    pkgs.manix
    pkgs.gemini-cli
    pkgs.alsa-plugins
    pkgs.libpulseaudio
  ];

  home.file = {
    ".agents/skills".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/.agents/skills";
		".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/ghostty";
  };


  home.sessionVariables = {
    DIRENV_LOG_FORMAT = "";
  };

  programs.home-manager.enable = true;

  programs = {

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
        spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
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
