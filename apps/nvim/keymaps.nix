{ ... }:
{
  programs.nixvim.keymaps = [
    {
      mode = [ "i" "n" ];
      key = "<S-CR>";
      action.__raw = ''
        function()
          local line = vim.api.nvim_get_current_line()
          if not line:match(";%s*$") then
            vim.api.nvim_set_current_line(line .. ";")
          end
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<End><CR>", true, true, true), "n", true)
        end
      '';
      options = {
        silent = true;
        desc = "Append semicolon and new line";
      };
    }

    {
      mode = [ "i" "n" ];
      key = "<A-CR>";
      action.__raw = ''
        function()
          local cursor = vim.api.nvim_win_get_cursor(0)
          local line = vim.api.nvim_get_current_line()
          if not line:match(";%s*$") then
            vim.api.nvim_set_current_line(line .. ";")
          end
          vim.api.nvim_win_set_cursor(0, cursor)
        end
      '';
      options = {
        silent = true;
        desc = "Append semicolon and stay";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>gb";
      action = "<cmd>Gitsigns toggle_current_line_blame<cr>";
      options.desc = "Toggle Line Blame";
    }
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
