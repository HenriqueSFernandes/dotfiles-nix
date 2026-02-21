{ ... }:
{
  programs.nixvim.plugins.flash = {
    enable = true;
    settings = {
      labels = "asdfghjklqwertyuiopzxcvbnm";
      search = {

        mode = "fuzzy";
        exclude = [
          "notify"
          "cmp_menu"
          "noice"
          "flash_prompt"
          "neo-tree"
          "aerial"
          "trouble"
        ];
        case_sensitive = "ignore_case";
      };
      jump.autojump = true;

    };
  };

  programs.nixvim.keymaps = [
    {
      mode = [ "n" "x" "o" ];
      key = "s";
      action = "<cmd>lua require('flash').jump()<cr>";
      options.desc = "Flash Jump";
    }
    {
      mode = [ "n" "x" "o" ];
      key = "S";
      action = "<cmd>lua require('flash').treesitter()<cr>";
      options.desc = "Flash Treesitter";
    }
  ];
}
