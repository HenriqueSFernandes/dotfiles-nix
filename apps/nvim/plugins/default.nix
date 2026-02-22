{ ... }:
{
  imports = [
    ./barbecue.nix
    ./bufferline.nix
    ./flash.nix
    ./lsp.nix
    ./telescope.nix
    ./trouble.nix
    ./ui.nix
    ./mini.nix
  ];

  programs.nixvim.plugins = {
    gitsigns.enable = true;
    persistence.enable = true;
    nvim-surround.enable = true;
    lazygit.enable = true;
    which-key.enable = true;
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
