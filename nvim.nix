{ config, pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;

    extraPackages = with pkgs; [
      stylua
      black
      isort
      prettierd
      nixpkgs-fmt
    ];
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    opts = {
      number = true;
      relativenumber = true;
    };

    autoCmd = [
      {
        event = "InsertEnter";
        pattern = "*";
        command = "set norelativenumber";
      }
      {
        event = "InsertLeave";
        pattern = "*";
        command = "set relativenumber";
      }
    ];

    keymaps = [
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
        action = ''
          <cmd>lua require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500 })<cr>
        '';
        options = {
          desc = "Format buffer";
          silent = true;
        };
      }
    ];

    plugins = {
      cursorline = {
        enable = true;
        settings.cursorline.timeout = 0;
      };

      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          lua_ls.enable = true;
        };

        keymaps.lspBuf = {
          "gd" = "definition";
          "gD" = "declaration";
          "gi" = "implementation";
          "gt" = "type_definition";
          "K" = "hover";
          "<leader>rn" = "rename";
          "<leader>ca" = "code_action";
        };
      };
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
            python = [
              "isort"
              "black"
            ];
            javascript = [
              "prettierd"
              "prettier"
            ];
            nix = [ "nixpkgs-fmt" ];
            "*" = [ "codespell" ];
            "_" = [ "trim_whitespace" ];
          };
        };
      };
      cmp = {
        enable = true;
        settings = {
          autoEnableSources = true;
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "luasnip"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
          };
        };
      };
      neo-tree = {
        enable = true;
      };
      nvim-autopairs = {
        enable = true;
      };
      treesitter = {
        enable = true;
        nixvimInjections = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };
      telescope = {
        enable = true;
        keymaps = {
          "<C-p>" = {
            action = "find_files";
            options = {
              desc = "Telescope: Find Files";
            };
          };

          "<C-f>" = {
            action = "live_grep";
            options = {
              desc = "Telescope: Live Grep";
            };
          };

          "gu" = {
            action = "lsp_references";
            options = {
              desc = "Telescope: Find Usages (LSP)";
            };
          };
        };
      };
    };
  };
}
