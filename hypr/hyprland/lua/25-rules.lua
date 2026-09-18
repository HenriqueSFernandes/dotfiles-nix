-- Window rules.
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

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
