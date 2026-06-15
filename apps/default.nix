{ ... }:
{
  imports = [
    ./browsers
    ./cli
    ./editors
    ./misc
    ./games
    ./rofi.nix
    ./social
    ./spotify.nix
    ./terminals
    ./tui
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "zathura";
    };
  };


}
