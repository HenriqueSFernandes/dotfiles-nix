{ ... }:
{
  programs.nixvim.plugins = {

    noice = {
      enable = true;
      settings = {
        lsp.override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.set_formatting_op" = true;
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

    notify.enable = true;
  };
}
