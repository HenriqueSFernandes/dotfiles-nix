{ config, pkgs, ... }:

let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "main";
    hash = "sha256-TzHJNIFZjUOImZ4dRC0hnB4xsDZCOuEjfXRi2ZXr8QE=";
  };

	sshfs-plugin = pkgs.fetchFromGitHub {
    owner = "uhs-robert";
    repo = "sshfs.yazi";
    rev = "main";
    hash = "sha256-p5ZsqlqsDtFA5f03U7qtBWtAfCzKnckez+g72rv7Stk=";
	};
in
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
    initLua = ./yazi/init.lua;
    keymap = builtins.fromTOML (builtins.readFile ./yazi/keymap.toml);
  };

  xdg.configFile."yazi/plugins/git.yazi" = {
    source = "${yazi-plugins}/git.yazi";
    recursive = true;
  };

  xdg.configFile."yazi/plugins/full-border.yazi" = {
    source = "${yazi-plugins}/full-border.yazi";
    recursive = true;
  };

  xdg.configFile."yazi/plugins/mount.yazi" = {
    source = "${yazi-plugins}/mount.yazi";
    recursive = true;
  };

  xdg.configFile."yazi/plugins/sshfs.yazi" = {
    source = "${sshfs-plugin}";
    recursive = true;
  };

}
