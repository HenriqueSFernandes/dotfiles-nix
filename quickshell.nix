{ config
, pkgs
, inputs
, ...
}:
let
  quickshellPkg = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default.withModules [
    pkgs.qt6.qtmultimedia
    pkgs.qt6.qtsvg
    pkgs.qt6.qtimageformats
    pkgs.qt6.qtmultimedia
    pkgs.qt6.qt5compat
  ];

  toggleMenu = pkgs.writeShellScriptBin "quickshell-toggle-menu" ''
    # Toggle the Ricky Quickshell menu via IPC.
    set -euo pipefail

    QS_CONFIG_PATH="''${QS_CONFIG_PATH:-$HOME/.config/quickshell}"

    # Ensure WAYLAND_DISPLAY is set when called from a context without it.
    if [[ -z ''${WAYLAND_DISPLAY:-} ]]; then
      socket=$(ls -t "''${XDG_RUNTIME_DIR:-/run/user/$UID}"/wayland-[0-9]* 2>/dev/null | grep -v '\.lock$' | head -n1)
      [[ -n $socket ]] && export WAYLAND_DISPLAY=''${socket##*/}
    fi

    exec ${quickshellPkg}/bin/quickshell ipc -p "$QS_CONFIG_PATH" call menu toggleMenu
  '';
in
{
  home.packages = [ quickshellPkg toggleMenu ];

  xdg.configFile."quickshell" = {
    source = ./quickshell;
    recursive = true;
    # The whole tree is Nix-managed, so overwrite anything already there
    # instead of failing activation with a clobber error.
    force = true;
  };

  # Autostart is handled in hypr/hyprland/lua/20-autostart.lua to stay
  # consistent with the rest of the Hyprland Lua configuration.
}
