{ ... }:
{
  imports = [
    ./barbecue.nix
    ./bufferline.nix
    ./copilot.nix
    ./flash.nix
    ./lsp.nix
    ./mini.nix
    ./spectre.nix
    ./telescope.nix
    ./trouble.nix
    ./ui.nix
  ];

  programs.nixvim.plugins = {
    gitsigns.enable = true;
    peek.enable = true;
    peek.createUserCommands = true;
    peek.settings.app = "browser";
    which-key.enable = true;
    auto-session.enable = true;
    nvim-surround.enable = true;
    lazygit.enable = true;
    web-devicons.enable = true;
    neo-tree.enable = true;
    nvim-autopairs.enable = true;
    ts-autotag.enable = true;
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
