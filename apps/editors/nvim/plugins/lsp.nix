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
    ];

    plugins = {
      clangd-extensions.enable = true;
      flutter-tools.enable = true;
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          lua_ls.enable = true;
          dockerls.enable = true;
          docker_compose_language_service.enable = true;
          clangd.enable = true;
          ts_ls.enable = true;
          biome.enable = true;
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
          python = [
            "isort"
            "black"
          ];
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
    };
  };
}
