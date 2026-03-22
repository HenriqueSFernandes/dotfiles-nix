{ config, inputs, pkgs, ... }:
{
  imports = [
    inputs.zen-browser.homeModules.beta
    ./shortcuts.nix
    ./search-alias.nix
    ./xdg-mime.nix
    ./spaces.nix
    ./pins.nix
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    profiles.${config.home.username} = {
      id = 0;
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "ui.systemUsesDarkTheme" = 1;
        "zen.theme.gradient.show-custom-colors" = true;
      };
    };
  };
}
