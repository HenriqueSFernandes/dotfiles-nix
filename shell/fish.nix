{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      ze = "zellij";
      lg = "lazygit";
      ld = "lazydocker";
      uni = "zellij -l uni";
      # lock = "$HOME/.config/hypr/start-custom-lock.sh";
      oldcat = "cat";
      cat = "bat";
      nix-switch = "sudo nixos-rebuild switch --flake ~/dotfiles#ricky-laptop";
      nix-conf = "cd ~/dotfiles && nvim";
      ls = "eza";

    };

		# functions = {
		# nix-conf = "cd $HOME/.config/home-manager; nvim home.nix";
		# };

    plugins = [
      {
        name = "git-abbr"; 
        src = pkgs.fetchFromGitHub {
          owner = "lewisacidic";
          repo = "fish-git-abbr";
          rev = "master";
					sha256 = "sha256-6z3Wr2t8CP85xVEp6UCYaM2KC9PX4MDyx19f/wjHkb0=";
        };
      }
    ];

    interactiveShellInit = ''
      bind \e\[1\;5D backward-word
      bind \e\[1\;5C forward-word
      bind \eOc forward-word
      bind \eOd backward-word

      set -g fish_greeting ""

      set -g fish_color_command green --bold
    '';
  };
}
