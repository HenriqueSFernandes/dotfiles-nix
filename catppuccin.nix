{ config, pkgs, ... }:

{
  catppuccin = {
    fish.enable = true;
    fish.flavor = "mocha";

    fzf.enable = true;
    fzf.accent = "blue";
    fzf.flavor = "mocha";

    eza.enable = true;
    eza.accent = "blue";
    eza.flavor = "mocha";

    yazi.enable = true;
    yazi.accent = "blue";
    yazi.flavor = "mocha";

    opencode.enable = true;
    opencode.flavor = "mocha";

    ghostty.enable = true;
    ghostty.flavor = "mocha";

    zellij.enable = true;
    zellij.flavor = "mocha";

    bat.enable = true;
    bat.flavor = "mocha";

    spotify-player.enable = true;
    spotify-player.flavor = "mocha";

    rofi.enable = true;
    rofi.flavor = "mocha";

    cursors.enable = true;
    cursors.accent = "dark";
    cursors.flavor = "mocha";
  };
}
