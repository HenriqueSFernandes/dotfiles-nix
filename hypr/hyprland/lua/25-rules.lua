-- Window rules.
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

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
