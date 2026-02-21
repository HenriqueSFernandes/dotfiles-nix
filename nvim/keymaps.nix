{ ... }:
{
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = ":Neotree filesystem reveal left toggle<CR>";
      options.desc = "Toggle file explorer";
    }
    {
      mode = "n";
      key = "<leader>n";
      action = "<cmd>nohls<cr>";
      options.desc = "Hide search results";
    }
    {
      mode = "n";
      key = "<C-d>";
      action = "Lzz";
      options.desc = "Scroll down and center";
    }
    {
      mode = "n";
      key = "<C-u>";
      action = "Hzz";
      options.desc = "Scroll up and center";
    }
    {
      mode = "n";
      key = "<M-F>";
      action = "<cmd>lua require('conform').format({ lsp_fallback = true, async = false, timeout_ms = 500 })<cr>";
      options = {
        desc = "Format buffer";
        silent = true;
      };
    }
  ];
}
