{ inputs, ... }:
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./plugins
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim.enable = true;
}
