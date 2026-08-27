-- Keybinds.
-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local vars = require("00-vars")

-- Basic Binds
hl.bind(vars.mod .. " + Q",      hl.dsp.exec_cmd(vars.terminal))
hl.bind(vars.mod .. " + C",      hl.dsp.window.close())
hl.bind(vars.mod .. " + M",      hl.dsp.exit())
hl.bind(vars.mod .. " + E",      hl.dsp.exec_cmd(vars.fileManager))
hl.bind(vars.mod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(vars.mod .. " + R",      hl.dsp.exec_cmd(vars.menu))
hl.bind(vars.mod .. " + W",      hl.dsp.exec_cmd("rofi -show window"))
hl.bind(vars.mod .. " + SHIFT + V", hl.dsp.exec_cmd("rofi -show cliphist"))
hl.bind(vars.mod .. " + N",      hl.dsp.layout("togglesplit"))

-- Move focus with mod + hjkl
hl.bind(vars.mod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(vars.mod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(vars.mod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(vars.mod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Switch to workspace with mod + number
hl.bind(vars.mod .. " + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind(vars.mod .. " + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind(vars.mod .. " + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind(vars.mod .. " + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind(vars.mod .. " + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind(vars.mod .. " + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind(vars.mod .. " + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind(vars.mod .. " + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind(vars.mod .. " + 9", hl.dsp.focus({ workspace = "9" }))
hl.bind(vars.mod .. " + 0", hl.dsp.focus({ workspace = "10" }))

-- Move window to workspace
hl.bind(vars.mod .. " + SHIFT + 1",  hl.dsp.window.move({ workspace = "1",  follow = false }))
hl.bind(vars.mod .. " + SHIFT + 2",  hl.dsp.window.move({ workspace = "2",  follow = false }))
hl.bind(vars.mod .. " + SHIFT + 3",  hl.dsp.window.move({ workspace = "3",  follow = false }))
hl.bind(vars.mod .. " + SHIFT + 4",  hl.dsp.window.move({ workspace = "4",  follow = false }))
hl.bind(vars.mod .. " + SHIFT + 5",  hl.dsp.window.move({ workspace = "5",  follow = false }))
hl.bind(vars.mod .. " + SHIFT + 6",  hl.dsp.window.move({ workspace = "6",  follow = false }))
hl.bind(vars.mod .. " + SHIFT + 7",  hl.dsp.window.move({ workspace = "7",  follow = false }))
hl.bind(vars.mod .. " + SHIFT + 8",  hl.dsp.window.move({ workspace = "8",  follow = false }))
hl.bind(vars.mod .. " + SHIFT + 9",  hl.dsp.window.move({ workspace = "9",  follow = false }))
hl.bind(vars.mod .. " + SHIFT + 0",  hl.dsp.window.move({ workspace = "10", follow = false }))

-- Resize window
hl.bind(vars.mod .. " + SHIFT + L", hl.dsp.window.resize({ x = 20,  y = 0,   relative = true }), { repeating = true })
hl.bind(vars.mod .. " + SHIFT + H", hl.dsp.window.resize({ x = -20, y = 0,   relative = true }), { repeating = true })
hl.bind(vars.mod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0,   y = -20, relative = true }), { repeating = true })
hl.bind(vars.mod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0,   y = 20,  relative = true }), { repeating = true })

-- Move windows
hl.bind(vars.mod .. " + SHIFT + CTRL + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(vars.mod .. " + SHIFT + CTRL + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(vars.mod .. " + SHIFT + CTRL + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(vars.mod .. " + SHIFT + CTRL + J", hl.dsp.window.move({ direction = "d" }))

-- Extra binds
hl.bind(vars.mod .. " + ALT + K", hl.dsp.exec_cmd("shutdown now"))
hl.bind(vars.mod .. " + F",     hl.dsp.window.fullscreen({ mode = 1, action = "toggle" }))
hl.bind(vars.mod .. " + P",     hl.dsp.exec_cmd("powermenu"))
hl.bind(vars.mod .. " + ALT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(vars.mod .. " + Print", hl.dsp.exec_cmd("screenshotmenu"))
hl.bind("Print",               hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(vars.mod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- Special Workspaces
hl.bind(vars.mod .. " + S",      hl.dsp.workspace.toggle_special("magic"))
hl.bind(vars.mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic", follow = false }))
hl.bind(vars.mod .. " + T",      hl.dsp.workspace.toggle_special("trash"))
hl.bind(vars.mod .. " + SHIFT + T", hl.dsp.window.move({ workspace = "special:trash", follow = false }))

-- Scroll Workspaces
hl.bind(vars.mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(vars.mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move workspace to another monitor
hl.bind(vars.mod .. " + SHIFT + CTRL + 1", hl.dsp.workspace.move({ monitor = "HDMI-A-1" }))
hl.bind(vars.mod .. " + SHIFT + CTRL + 2", hl.dsp.workspace.move({ monitor = "eDP-1" }))

-- Media keys
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"))

-- Brightness / Volume
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 10%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"))
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("pamixer -i 5"))
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("pamixer -d 5"))
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("pamixer -t"))
hl.bind("XF86PowerOff",          hl.dsp.exec_cmd("powermenu"))

-- Mouse binds
hl.bind(vars.mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(vars.mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
