{ config, lib, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    extraConfig = {
      show-icons = true;
      terminal = "ghostty";
      drun-display-format = "{icon} {name}";
      display-drun = "   Apps ";
      display-window = "   Windows ";
    };
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
        flavor = "mocha";
        accent = "blue";
        colors = (lib.importJSON "${pkgs.catppuccin}/palette/palette.json").${flavor}.colors;
      in
      {
        "*" = {
          bg-col = mkLiteral "${colors.base.hex}";
          bg-col-light = mkLiteral "${colors.mantle.hex}";
          border-col = mkLiteral "${colors.lavender.hex}";
          selected-col = mkLiteral "${colors.surface0.hex}";
          blue = mkLiteral "${colors.blue.hex}";
          fg-col = mkLiteral "${colors.text.hex}";
          fg-col2 = mkLiteral "${colors.red.hex}";
          grey = mkLiteral "${colors.overlay0.hex}";

          width = 800;
          font = "FiraCode Nerd Font Mono 14";
        };
        "element-text, element-icon, mode-switcher" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };
        "window" = {
          height = mkLiteral "450px";
          border = mkLiteral "3px";
          border-radius = mkLiteral "15px";
          border-color = mkLiteral "@border-col";
          background-color = mkLiteral "@bg-col";
        };

        "mainbox" = {
          background-color = mkLiteral "@bg-col";
        };

        "inputbar" = {
          children = map mkLiteral [ "prompt" "entry" ];
          background-color = mkLiteral "@bg-col";
          border-radius = mkLiteral "5px";
          padding = mkLiteral "5px";
        };

        "prompt" = {
          background-color = mkLiteral "@blue";
          padding = mkLiteral "8px 12px";
          text-color = mkLiteral "@bg-col";
          border-radius = mkLiteral "10px";
          margin = mkLiteral "20px 0px 0px 20px";
        };

        "textbox-prompt-colon" = {
          expand = false;
          str = ":";
        };

        "entry" = {
          padding = mkLiteral "6px";
          margin = mkLiteral "20px 0px 0px 10px";
          text-color = mkLiteral "@fg-col";
          background-color = mkLiteral "@bg-col";
        };

        "listview" = {
          border = mkLiteral "0px 0px 0px";
          padding = mkLiteral "6px 0px 0px";
          margin = mkLiteral "10px 0px 0px 20px";
          columns = 2;
          lines = 6;
          background-color = mkLiteral "@bg-col";
          scrollbar = false;
        };

        "element" = {
          padding = mkLiteral "10px";
          margin = mkLiteral "5px";
          border-radius = mkLiteral "10px";
          background-color = mkLiteral "@bg-col";
          text-color = mkLiteral "@fg-col";
        };

        "element selected" = {
          background-color = mkLiteral "@selected-col";
          text-color = mkLiteral "@blue";
        };

        "mode-switcher" = {
          spacing = 0;
        };

        "button" = {
          padding = mkLiteral "10px";
          background-color = mkLiteral "@bg-col-light";
          text-color = mkLiteral "@grey";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.5";
        };

        "button selected" = {
          background-color = mkLiteral "@bg-col";
          text-color = mkLiteral "@blue";
        };

        "scrollbar" = {
          enabled = false;
        };

      };
  };
}
