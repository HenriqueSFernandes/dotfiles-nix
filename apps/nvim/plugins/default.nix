{ ... }:
{
  imports = [
    ./barbecue.nix
    ./bufferline.nix
    ./copilot.nix
    ./flash.nix
    ./lsp.nix
    ./mini.nix
    ./telescope.nix
    ./trouble.nix
    ./which-key.nix
    ./ui.nix
  ];

  programs.nixvim.plugins = {
    gitsigns.enable = true;
    auto-session.enable = true;
    nvim-surround.enable = true;
    lazygit.enable = true;
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
