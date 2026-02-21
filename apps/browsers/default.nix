{ config, inputs, ... }:
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs = {
    zen-browser = {
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
          engines = {
            home-manager = {
              name = "Home Manager Option Seach";
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=release-25.11";
                  params = [
                    {
                      name = "query";
                      value = "searchTerms";
                    }
                  ];
                }
              ];
              definedAlias = [ "@hm" ];
            };
          };
        };

      };
    };
  };
}
