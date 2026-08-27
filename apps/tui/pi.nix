{ ... }:
{
  programs.pi.coding-agent = {
    enable = true;
    rules = ./rules.md;
  };
}
