{ config, pkgs, ... }:
{

  programs.zen-browser.profiles.${config.home.username}.search = {
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
}
