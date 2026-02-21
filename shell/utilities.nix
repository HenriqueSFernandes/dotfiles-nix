{ ... }:
{
  programs = {

    bat = {
      enable = true;
      config = {
        style = "grid,header";
      };
    };
    eza = {
      enable = true;
      enableFishIntegration = true;
      icons = "always";
      colors = "always";
      git = true;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
    };

    fd = {
      enable = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [
        "--cmd cd"
      ];
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
      silent = true;
    };

    ripgrep.enable = true;
  };

}
