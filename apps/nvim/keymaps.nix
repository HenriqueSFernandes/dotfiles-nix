{ ... }:
{
  programs.nixvim.keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>gg";
      action = "<cmd>LazyGit<cr>";
      options.desc = "Open LazyGit";
    }
    {
      mode = [ "n" "v" ];
      key = "<Tab>";
      action = "<cmd>BufferLineCycleNext<cr>";
      options.desc = "Next Buffer";
    }
    {
      mode = [ "n" "v" ];
      key = "<S-Tab>";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options.desc = "Previous Buffer";
    }
    {
      mode = [ "n" "v" ];
      key = "<leader>w";
      action = "<cmd>bd<cr>";
      options.desc = "Close Buffer";
    }
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options.desc = "Move to left split";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options.desc = "Move to below split";
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options.desc = "Move to above split";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options.desc = "Move to right split";
    }
    {
      mode = "i";
      key = "<C-h>";
      action = "<C-w>";
      options.desc = "Delete word backward";
    }
    {
      mode = "c";
      key = "<C-h>";
      action = "<C-w>";
      options.desc = "Delete word backward in command mode";
    }
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
