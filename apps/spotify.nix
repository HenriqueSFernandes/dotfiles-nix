{ inputs, pkgs, ... }:
{
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
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        enable = true;
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";
      };
  };
}
