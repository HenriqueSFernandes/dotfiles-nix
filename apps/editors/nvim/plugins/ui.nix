{ ... }:
{
  programs.nixvim.plugins = {

    snacks = {
      enable = true;
      settings = {
        input.enabled = true;

        picker = {
          enabled = true;
        };

        notifier.enabled = true;
        # scope.enabled = true; 
        # words.enabled = true;
      };
    };

    highlight-colors.enable = true;

    noice = {
      enable = true;
      settings = {
        lsp.override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.set_formatting_op" = true;
          "cmp.entry.get_documentation" = true;
        };
        presets = {
          bottom_search = true;
          command_palette = false;
          long_message_to_split = true;
          inc_rename = true;
          lsp_doc_border = false;
        };
      };
    };
  };
}
