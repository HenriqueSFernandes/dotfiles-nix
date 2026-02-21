{ ... }:
{
  imports = [
    ./spotify.nix
    ./browsers
    ./nvim
    ./tui
    ./rofi.nix
  ];

  programs = {
    vesktop.enable = true;
  };

}
