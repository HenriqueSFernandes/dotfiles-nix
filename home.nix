{ config
, pkgs
, inputs
, ...
}:

{
  imports = [
    ./apps
    ./hypr
    ./shell
    ./themes
  ];

  home = {
    username = "ricky";
    homeDirectory = "/home/ricky";

    stateVersion = "25.11";

    file = {
      ".agents/skills".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.agents/skills";
    };

    packages = with pkgs; [
      manix
      gemini-cli
      thunar
      playerctl
      brightnessctl
      pamixer
      whatsapp-electron
    ];

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };
  };

  programs.home-manager.enable = true;

  services = {
    swww.enable = true;
  };
}
