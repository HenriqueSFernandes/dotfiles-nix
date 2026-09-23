# Quickshell Alt+Space Menu

## Context

The Omarchy desktop ships a `Super + Space` (and `Super + Alt + Space`) Quickshell menu that lists apps, triggers capture/emoji/toggle submenus, and exposes system actions from a JSONC data file. The goal is to build a similar keyboard-driven menu inside this NixOS dotfiles repo, using the already-installed `quickshell` package.

### User decisions

- **Scope:** build the menu now, but structure files so a full Quickshell desktop shell (bar, panels, etc.) can be added later without rewriting.
- **Keybinding:** `Super + Space` (Omarchy-style).
- **rofi:** keep existing rofi tools alongside for now.
- **Feature set:** minimal first — apps, a trigger submenu (emoji/capture/toggles), system actions, and update commands. No install/remove/setup catalogs in v1.

### Current state

- `quickshell` is already in `packages.nix` as a Home Manager package (version 0.3.1 in current nixpkgs).
- No `~/.config/quickshell` or repo `quickshell/` config exists yet.
- Hyprland is configured via Lua (`hypr/hyprland/lua/`); current launcher is `rofi -show drun` bound to `SUPER + R`.
- Existing rofi-based helpers live in `apps/rofi.nix`: `powermenu`, `screenshotmenu`, `clip-history`.
- The panel is currently Wayle/HyprPanel (`hypr/hyprpanel.nix`). A future Quickshell bar may replace it, but the menu must not depend on it.
- Omarchy's menu is a Quickshell plugin inside a full shell (`shell/plugins/menu/Menu.qml`, data in `default/omarchy/omarchy-menu.jsonc`). It relies on `omarchy-shell` IPC (`qs ipc`) and a shared `AppLibrary` service.

We cannot drop Omarchy in whole; we can reuse its **data shape** (JSONC menu tree) and **UI patterns**, but build a standalone Quickshell panel that is summoned directly from Hyprland.

## Approach

Build a single-purpose Quickshell panel with expansion hooks:

1. **Entry point** — a new directory `quickshell/` at the repo root. Home Manager will link it to `~/.config/quickshell` so `qs` can load the default config. `shell.qml` creates only a `WlrLayershell` popup window for the menu; no bar yet, but files are organized so a `bar/` directory can be added later.
2. **Menu data** — `menu.jsonc` defining the tree:
   - `apps` — provider-backed app launcher.
   - `trigger` — Emoji picker (built-in), Capture (screenshot/screenrecord), Toggles (nightlight via `hyprsunset`, stay-awake via `caffeine-ng`, screensaver via `hyprlock` or `loginctl lock-session`).
   - `system` — Lock, Logout, Reboot, Power Off, Suspend.
   - `update` — `nh os switch` (replaces the old `nix-switch-laptop` script now that the desktop is gone).
3. **App listing provider** — use `Quickshell.DesktopEntries` (if available in 0.3.1) or parse `.desktop` files manually via a small provider script. Merge results under `apps`.
4. **Actions** — shell commands launched via `Quickshell.Io.Process` or `Qt.callLater` with `QProcess`.
5. **Hyprland integration** — bind `Super + Space` in `hypr/hyprland/lua/30-binds.lua` to run a small wrapper script `~/.config/quickshell/toggle-menu` that calls `qs ipc -p ~/.config/quickshell call menu toggleMenu`.
6. **Toggle IPC** — the QML root exposes an `IpcHandler` named `menu` with a `toggleMenu()` function. The wrapper script uses `qs ipc -p "$HOME/.config/quickshell" call menu toggleMenu`.
7. **Styling** — Catppuccin Mocha palette, matching the existing rofi theme (`apps/rofi.nix`) and Hyprland active border (`rgba(89B4FBEE)`).

## Files to modify / create

- Create `quickshell/shell.qml` — `ShellRoot` with an `IpcHandler` and a hidden `WlrLayershell` popup.
- Create `quickshell/Menu.qml` — the menu UI: header, filter `TextField`, `ListView` rows, keyboard navigation, provider loading.
- Create `quickshell/MenuModel.js` — JSONC stripping, tree normalization, search scoring, and visibility helpers (heavily inspired by Omarchy's `shell/plugins/menu/MenuModel.js`).
- Create `quickshell/menu.jsonc` — user menu data (apps provider, trigger, system, update).
- Create `quickshell/Theme.qml` or `Colors.qml` — Catppuccin color constants.
- Create `quickshell/toggle-menu` — shell wrapper invoked by Hyprland.
- Create `quickshell/quickshell.nix` — Home Manager module linking `quickshell/` to `xdg.configHome`, adding `quickshell` to autostart, and possibly setting `QS_CONFIG_PATH`.
- Modify `hypr/hyprland/lua/30-binds.lua` — add `Super + Space` bind to the toggle wrapper.
- Modify `hypr/hyprland/lua/20-autostart.lua` — start `quickshell` on login.
- Modify `packages.nix` only if extra Quickshell modules (e.g. `qt6.qtmultimedia`) are needed beyond the current list.

## Reuse

- **Omarchy `Menu.qml` + `MenuModel.js`** — reference implementation for JSONC tree, provider contracts, guard evaluation, search scoring, and row rendering.
- **`apps/rofi.nix`** — existing action commands (`powermenu`, `screenshotmenu`) can be ported to JSONC actions.
- **Catppuccin palette** — already imported in `apps/rofi.nix`; can be reused for Quickshell color constants.
- **`Quickshell.Wayland.WlrLayershell`** — for the overlay/panel surface.
- **`Quickshell.Io`** — for running provider scripts and actions.
- **`Quickshell.IpcHandler`** — for the `Super + Space` toggle from Hyprland.

## Steps

- [x] Decide scope: menu now, full shell later.
- [x] Decide keybinding: `Super + Space`.
- [x] Confirm rofi stays alongside.
- [x] Confirm minimal v1 feature set: Apps, Trigger, System, Update.
- [x] Scaffold `quickshell/` directory and `shell.qml` with a `WlrLayershell` popup and `IpcHandler`.
- [x] Port a minimal `MenuModel.js` for JSONC parsing, tree flattening, and search scoring.
- [x] Implement `Menu.qml` with header, filter `TextField`, `ListView` rows, keyboard navigation, and provider hooks.
- [x] Implement app provider (desktop entries) under `apps`.
- [x] Define trigger/capture/toggle/system/update actions in `menu.jsonc`.
  - Nightlight: `pkill hyprsunset || hyprsunset`.
  - Stay awake: `caffeine` toggle.
  - Screensaver: `hyprlock`.
  - Update: `nh os switch`.
  - Emoji: built-in Quickshell list copied to clipboard via `wl-copy`.
- [x] Add `Super + Space` Hyprland bind and the `toggle-menu` wrapper.
- [x] Autostart Quickshell in Hyprland autostart.
- [x] Verify on live session: open menu, type to filter, launch app, run toggle, navigate with arrows.

## Verification

- Run `quickshell` manually and press `Super + Space`; menu appears centered/top.
- Type to filter root items and apps; selection updates.
- Press Enter on an app action; app launches and menu closes.
- Drill into Trigger > Capture and run a screenshot command.
- Toggle nightlight/stay-awake and confirm state changes (e.g. via `hyprctl` or notification).
- Run `nixos-rebuild switch` (or `home-manager switch`) cleanly with the new config.
