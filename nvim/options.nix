{ pkgs, ... }:
{
  programs.nixvim = {
    colorschemes.catppuccin.enable = true;

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
  };
}
