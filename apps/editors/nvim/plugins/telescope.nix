{ ... }:
{
  programs.nixvim.plugins.telescope = {
    enable = true;
    keymaps = {
      "<C-p>" = {
        action = "find_files";
        options.desc = "Telescope: Find Files";
      };
      "<C-f>" = {
        action = "live_grep";
        options.desc = "Telescope: Live Grep";
      };
      "gu" = {
        action = "lsp_references";
        options.desc = "Telescope: Find Usages (LSP)";
      };
    };
  };
}
