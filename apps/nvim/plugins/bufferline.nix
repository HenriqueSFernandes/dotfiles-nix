{ ... }:
{
  programs.nixvim.plugins.bufferline = {
    enable = true;
    settings.options = {
      offsets = [
        {
          filetype = "neo-tree";
          text = "File Explorer";
          highlight = "Directory";
          text_align = "left";
        }
      ];
      separator_style = "thin";
    };
  };
}
