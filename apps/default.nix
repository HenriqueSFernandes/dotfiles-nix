{ ... }:
{
  imports = [
    ./browsers
    ./cli
    ./editors
    ./misc
    ./rofi.nix
    ./social
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
