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

    opencode.enable = true;
    opencode.flavor = "mocha";
  };
}
