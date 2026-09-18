{ ... }:
{
  # <C-h/j/k/l> move between nvim splits; at a split edge, cross into the
  # neighbouring herdr pane. Needs $HERDR_PANE_ID (herdr-injected) and the
  # vim-herdr-navigation herdr plugin, which owns the same chord globally.
  programs.nixvim.extraConfigLua = ''
    local function herdr_nav(wincmd, dir)
      local prev = vim.api.nvim_get_current_win()
      vim.cmd("wincmd " .. wincmd)
      if vim.api.nvim_get_current_win() ~= prev then
        return -- moved within nvim
      end
      local pane = vim.env.HERDR_PANE_ID
      if pane == nil or pane == "" then
        return -- not inside a herdr pane
      end
      local bin = vim.env.HERDR_BIN_PATH
      if bin == nil or bin == "" then
        bin = "herdr"
      end
      -- Target this pane explicitly: --current resolves to the server's
      -- globally focused pane, which may not be the one running nvim.
      vim.fn.system({ bin, "pane", "focus", "--direction", dir, "--pane", pane })
    end
    _G.herdr_nav = herdr_nav
  '';

  programs.nixvim.keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>m";
      action = ":PeekOpen<cr>";
      options.desc = "Open markdown preview";
    }
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
      key = "<leader>o";
      action = "<cmd>AerialToggle right<cr>";
      options.desc = "Toggle Outline";
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
      action.__raw = "function() _G.herdr_nav('h', 'left') end";
      options = {
        silent = true;
        desc = "Navigate left (vim/herdr)";
      };
    }
    {
      mode = "n";
      key = "<C-j>";
      action.__raw = "function() _G.herdr_nav('j', 'down') end";
      options = {
        silent = true;
        desc = "Navigate down (vim/herdr)";
      };
    }
    {
      mode = "n";
      key = "<C-k>";
      action.__raw = "function() _G.herdr_nav('k', 'up') end";
      options = {
        silent = true;
        desc = "Navigate up (vim/herdr)";
      };
    }
    {
      mode = "n";
      key = "<C-l>";
      action.__raw = "function() _G.herdr_nav('l', 'right') end";
      options = {
        silent = true;
        desc = "Navigate right (vim/herdr)";
      };
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
