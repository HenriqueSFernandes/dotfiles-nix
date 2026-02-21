{ ... }:
{
  programs.nixvim.plugins.barbecue = {
    enable = true;
    settings = {
      attach_navic = true;
      show_modified = true;
      exclude_filetypes = [
        "neo-tree"
        "toggleterm"
        "help"
      ];
    };
  };

  programs.nixvim.plugins.navic = {
    enable = true;
    settings = {
      highlight = true;
      click = true;
    };
  };
}
