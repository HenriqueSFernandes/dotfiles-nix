{ ... }:
{
  imports = [
    ./spotify.nix
    ./browsers
    ./nvim
    ./tui
    ./terminals
    ./rofi.nix
  ];

  programs = {
    vesktop.enable = true;
  };

}
