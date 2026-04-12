{ pkgs, ... }:
{
  programs.nixvim = {
    extraPackages = with pkgs; [
      gopls
      gofumpt
      go-tools
      gotools
      stylua
      black
      isort
      prettierd
      nixpkgs-fmt
      codespell
      clang-tools
      biome
      rustfmt
      vscode-langservers-extracted
      tailwindcss-language-server
      yaml-language-server
    ];

    plugins = {
      clangd-extensions.enable = true;
      flutter-tools.enable = true;
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          tailwindcss.enable = true;
          lua_ls.enable = true;
          dockerls.enable = true;
          docker_compose_language_service.enable = true;
          nixd.enable = true;
          clangd.enable = true;
          ts_ls.enable = true;
          biome.enable = true;
          basedpyright.enable = true;
          jsonls = {
            enable = true;
            filetypes = [ "json" "jsonc" ];
          };
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          gopls = {
            enable = true;
            settings = {
              analyses = {
                unusedparams = true;
              };
              staticcheck = true;
              gofumpt = true;
            };
          };
          yamlls = {
            enable = true;
            settings = {
              yaml = {
                schemaStore = {
                  enable = true;
                  url = "https://www.schemastore.org/api/json/catalog.json";
                };
                validate = true;
                completion = true;
                hover = true;
              };

            };

          };
        };
        keymaps.lspBuf = {
          "gd" = "definition";
          "gD" = "declaration";
          "gi" = "implementation";
          "gt" = "type_definition";
          "K" = "hover";
          "<leader>rn" = "rename";
          "<leader>v" = "code_action";
        };
      };

      conform-nvim = {
        enable = true;
        settings.formatters_by_ft = {
          lua = [ "stylua" ];
          python = [ "ruff_format" "ruff_organize_imports" ];
          javascript = [ "biome" ];
          typescript = [ "biome" ];
          javascriptreact = [ "biome" ];
          go = [ "goimports" "gofumpt" ];
          typescriptreact = [ "biome" ];
          rust = [ "rustfmt" ];
          markdown = [ "prettierd" ];
          nix = [ "nixpkgs_fmt" ];
          c = [ "clang-format" ];
          cpp = [ "clang-format" ];
          json = [ "biome" ];
          jsonc = [ "biome" ];
          "*" = [ "codespell" ];
          "_" = [ "trim_whitespace" ];
        };
      };

      blink-cmp = {
        enable = true;
        settings = {
          sources.default = [ "lsp" "path" "snippets" "buffer" ];

          keymap = {
            preset = "none";
            "<C-space>" = [ "show" "fallback" ];
            "<CR>" = [ "accept" "fallback" ];

            "<Tab>" = [ "select_next" "fallback" ];
            "<S-Tab>" = [ "select_prev" "fallback" ];
            "<Down>" = [ "select_next" "fallback" ];
            "<Up>" = [ "select_prev" "fallback" ];

            "<C-k>" = [ "show_documentation" "hide_documentation" "fallback" ];
            "<C-b>" = [ "scroll_documentation_up" "fallback" ];
            "<C-f>" = [ "scroll_documentation_down" "fallback" ];
          };

          appearance = {
            use_nvim_cmp_as_default = true;
            nerd_font_variant = "mono";
          };

          completion = {
            menu.draw.columns = [
              [ "kind_icon" ]
              [ "label" "label_description" ]
            ];
            documentation.auto_show = false;
            ghost_text.enabled = true;
          };
        };
      };
    };
  };
}
