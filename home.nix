{ config
, pkgs
, inputs
, ...
}:

{
  home.username = "ricky";
  home.homeDirectory = "/home/ricky";

  home.stateVersion = "25.11";

  imports = [
    ./apps
    ./catppuccin.nix
    ./hypr
    ./shell
    inputs.nixvim.homeModules.nixvim
  ];

  home.packages = [
    pkgs.manix
    pkgs.gemini-cli
    pkgs.thunar
  ];

  home.file = {
    ".agents/skills".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.agents/skills";
  };

  home.sessionVariables = {
    DIRENV_LOG_FORMAT = "";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  programs.home-manager.enable = true;

  services = {
    swww.enable = true;
  };

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
        keybind = "ctrl+backspace=text:\\x17";
      };
    };

    opencode = {
      enable = true;
    };

    vesktop = {
      enable = true;
    };

  };
}
