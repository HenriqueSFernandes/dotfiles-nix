{ ... }:
{
  imports = [
    ./lsp.nix
    ./telescope.nix
  ];

  programs.nixvim.plugins = {
    web-devicons.enable = true;
    neo-tree.enable = true;
    nvim-autopairs.enable = true;
    cursorline = {
      enable = true;
      settings.cursorline.timeout = 0;
    };
    treesitter = {
      enable = true;
      nixvimInjections = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };
    lualine = {
      enable = true;
      settings.options.theme = "catppuccin";
    };
  };
}
