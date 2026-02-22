{ config, inputs, pkgs, ... }:
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;
    suppressXdgMigrationWarning = true;
    profiles.${config.home.username} = {
      id = 0;
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "ui.systemUsesDarkTheme" = 1;
      };
      userChrome = ''
        @import url("https://raw.githubusercontent.com/catppuccin/zen-browser/main/themes/mocha/mocha.css");
      '';

      userContent = ''
        @import url("https://raw.githubusercontent.com/catppuccin/zen-browser/main/themes/mocha/mocha.css");
      '';

      search = {
        force = true;
        default = "google";
        engines =
          let
            nixSnowflakeIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          in
          {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "channel"; value = "25.11"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }
              ];
              icon = nixSnowflakeIcon;
              definedAliases = [ "p" ];
            };
            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    { name = "channel"; value = "25.11"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }
              ];
              icon = nixSnowflakeIcon;
              definedAliases = [ "o" ];
            };
            "Home Manager Options" = {
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/";
                  params = [
                    { name = "query"; value = "{searchTerms}"; }
                    { name = "release"; value = "release-25.11"; }
                  ];
                }
              ];
              icon = nixSnowflakeIcon;
              definedAliases = [ "hm" ];
            };
            "Nixvim Options" = {
              urls = [
                {
                  template = "https://nix-community.github.io/nixvim/";
                  params = [
                    { name = "search"; value = "{searchTerms}"; }
                  ];
                }
              ];
              definedAliases = [ "nv" ];
            };
          };
      };

    };
  };
  xdg.mimeApps =
    let
      associations = builtins.listToAttrs (map
        (name: {
          inherit name;
          value = "zen-beta.desktop";
        }) [
        "application/x-extension-shtml"
        "application/x-extension-xhtml"
        "application/x-extension-html"
        "application/x-extension-xht"
        "application/x-extension-htm"
        "x-scheme-handler/unknown"
        "x-scheme-handler/mailto"
        "x-scheme-handler/chrome"
        "x-scheme-handler/about"
        "x-scheme-handler/https"
        "x-scheme-handler/http"
        "application/xhtml+xml"
        "application/json"
        "text/plain"
        "text/html"
      ]);
    in
    {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
}
