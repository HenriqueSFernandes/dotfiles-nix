{ ... }:
{
  imports = [
    ./browsers
    ./cli
    ./editors
    ./misc
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
