{ config, pkgs, inputs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;

  # pi installs its npm extension packages at runtime into the agent directory.
  # Some of them pull native addons that ship prebuilds for darwin/win32 only
  # (@plannotator/pi-extension -> @plannotator/webtui -> node-pty), so on Linux
  # npm falls back to `node-gyp rebuild`, which needs python3, a C++ compiler
  # and make on PATH. Expose those to pi (and the npm it spawns) only, instead
  # of adding a compiler to the whole session.
  piPackage = inputs.pi.packages.${system}.coding-agent;
in
{
  programs.pi.coding-agent = {
    enable = true;
    package = pkgs.symlinkJoin {
      name = "pi-coding-agent-with-native-build-tools";
      paths = [ piPackage ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/pi \
          --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.python3 pkgs.gcc pkgs.gnumake ]}
      '';
      meta = piPackage.meta // {
        mainProgram = "pi";
      };
    };
    rules = ./rules.md;
    settings = {
      theme = "catppuccin-mocha";
      defaultProvider = "opencode-go";
      defaultModel = "kimi-k2.7-code";
      defaultThinkingLevel = "high";
      hideThinkingBlock = true;
      packages = [
        "npm:pi-mcp-adapter"
        "npm:pi-web-access"
        "npm:@juicesharp/rpiv-ask-user-question"
        "npm:pi-lens"
        "npm:pi-hermes-memory"
        "npm:pi-nvim"
        "npm:@juicesharp/rpiv-todo"
        "npm:@plannotator/pi-extension"
        "npm:pi-powerline-footer"
        "npm:@narumitw/pi-btw"
        "npm:@narumitw/pi-usage"
      ];
    };
  };

  home.file."${config.programs.pi-coding-agent.configDir}/themes/catppuccin-mocha.json".source =
    ./pi-catppuccin-mocha.json;
}
