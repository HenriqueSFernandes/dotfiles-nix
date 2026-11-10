-- Window rules.
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Replaces the deprecated dwindle.special_scale_factor. Both special
-- workspaces (magic / SUPER+S, trash / SUPER+T) are drawn as 80%-size overlays
-- by adding CSS-style outer gaps. On 1920x1080 this leaves a 1536x864 usable
-- area, matching the old 0.8 scale factor.
hl.workspace_rule({ workspace = "special:magic", gaps_out = { top = 108, right = 192, bottom = 108, left = 192 } })
hl.workspace_rule({ workspace = "special:trash", gaps_out = { top = 108, right = 192, bottom = 108, left = 192 } })

-- The Quickshell menu is a layer-shell overlay, not a tiled window. This rule
-- only removes its open/close animation so it snaps in like a menu.
hl.layer_rule({
  name = "ricky-menu-no-anim",
  match = { namespace = "^(ricky-menu)$" },
  no_anim = true,
  animation = "none",
})

hl.window_rule({
  name = "clipboard-history-float",
  match = { title = "Clipboard History" },
  float = true,
})

-- Browser extension popups (e.g. Bitwarden) have titles starting with
-- "Extension:" while the class is just the browser's.
hl.window_rule({
  name = "browser-extension-popup-float",
  match = { title = "^Extension:" },
  float = true,
})
