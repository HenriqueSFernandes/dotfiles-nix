{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    profiles.ricky = {
      extensions = with pkgs.vscode-extensions; [
      ];
    };
  };
}
