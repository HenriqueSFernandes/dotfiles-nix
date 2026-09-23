import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

ShellRoot {
  id: root

  property bool menuOpen: false

  // Set once the menu Loader resolves, so IPC can reach the menu's functions.
  property var menuItem: null

  IpcHandler {
    target: "menu"

    function toggleMenu(): void {
      root.menuOpen = !root.menuOpen;
    }

    function openMenu(): void {
      root.menuOpen = true;
    }

    function closeMenu(): void {
      root.menuOpen = false;
    }

    function summon(route: string): void {
      root.menuOpen = true;
      if (root.menuItem) root.menuItem.openRoute(route || "root");
    }

    function ping(): string {
      return "pong";
    }
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel

      property var modelData
      screen: modelData

      visible: root.menuOpen
      color: "transparent"

      implicitWidth: 760
      implicitHeight: menuLoader.item ? menuLoader.item.implicitHeight : 580

      anchors {
        top: true
      }

      margins {
        top: Math.round((panel.screen.height - panel.implicitHeight) / 2)
        left: Math.round((panel.screen.width - panel.implicitWidth) / 2)
      }

      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.namespace: "ricky-menu"
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
      // A menu overlays the desktop; it must not reserve screen space or
      // Hyprland shrinks the tiled windows underneath it when it opens.
      exclusionMode: ExclusionMode.Ignore

      Loader {
        id: menuLoader
        anchors.fill: parent
        source: "Menu.qml"
        active: true

        onLoaded: {
          root.menuItem = item;
          item.closed.connect(function () { root.menuOpen = false; });
          item.opened = Qt.binding(function () { return root.menuOpen; });
        }
      }
    }
  }
}
