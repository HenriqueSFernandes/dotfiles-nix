{ config
, pkgs
, inputs
, hostname
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
      wrangler
      brightnessctl
      hyprpicker
      cloudflared
      thunar
      zulip
      deno
      libreoffice-qt
      hunspell
      hunspellDicts.pt_PT
      hunspellDicts.en_US
      deploy-rs
      tldr
    ];

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  programs.home-manager.enable = true;

  services = {
    swww.enable = true;
  };
}
