{ pkgs, ... }:
{
  programs.nixvim = {
    extraPackages = with pkgs; [
      stylua
      black
      isort
      prettierd
      nixpkgs-fmt
      codespell
    ];

    plugins = {
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
        settings.formatters_by_ft = {
          lua = [ "stylua" ];
          python = [
            "isort"
            "black"
          ];
          javascript = [
            "prettierd"
          ];
          nix = [ "nixpkgs_fmt" ];
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
