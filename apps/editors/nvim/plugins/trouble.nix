{ ... }:
{
  programs.nixvim.plugins.trouble = {
    enable = true;
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>Trouble diagnostics toggle<cr>";
      options.desc = "Project Diagnostics (Trouble)";
    }
    {
      mode = "n";
      key = "<leader>xd";
      action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
      options.desc = "Buffer Diagnostics (Trouble)";
    }
  ];
}
