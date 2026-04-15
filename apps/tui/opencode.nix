{ pkgs, config, ... }:
{
  home.file = {
    ".agents/skills".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.agents/skills";
  };

  home.packages = with pkgs; [
    poppler-utils
  ];

  programs.opencode = {
    enable = true;
    package = pkgs.opencode;
    settings = {
      "$schema" = "https://opencode.ai/config.json";
      model = "opencode-go/minimax-m2.7";
      mcp = {
        cloudflare-radar = {
          type = "remote";
          url = "https://radar.mcp.cloudflare.com/mcp";
          enabled = false;
          timeout = 15000;
        };
      };

      agent = {
        build = {
          model = "opencode-go/minimax-m2.7";
          description = "Heavy lifting: Use for writing complex logic and multi-file changes.";
        };
        plan = {
          model = "opencode-go/kimi-k2.5";
          description = "The Thinker: Use Kimi's huge context to explain files or map out features.";
        };
      };

      command = {
        ui = {
          template = "Analyze the UI in these files and improve the styling/UX. Use Tailwind if available. If you can find a file called UI_GUIDELINES.md, use it as guidelines to implement. If such file is not available, create one with the UI guidelines after you finish the UI/UX rework.";
          model = "opencode-go/kimi-k2.5";
          description = "Specialized UI/Frontend pass using Kimi";
        };
        debug = {
          template = "Run the tests and fix any failing logic. Use terminal commands to verify.";
          model = "opencode-go/glm-5";
          description = "Deep backend debug pass using GLM-5";
        };
        quick = {
          template = "$ARGUMENTS";
          model = "opencode-go/minimax-m2.5";
          description = "Fast & cheap task (saves your 'premium' logic for later)";
        };
        issue = {
          template = "Run `gh issue view $ARGUMENTS` to view the GitHub issue details, then create a plan to implement it using Kimi's large context.";
          model = "opencode-go/kimi-k2.5";
          description = "View and plan a GitHub issue by number (e.g. /issue 123)";
        };
      };

      provider = {
        opencode-go = {
          models = {
            "minimax-m2.7" = {
              variants = {
                low = { reasoningEffort = "low"; description = "Fast & Cheap"; };
                high = { reasoningEffort = "high"; description = "Deep Logic (Opus-style)"; };
              };
            };
            "kimi-k2.5" = {
              variants = {
                none = { description = "Standard Chat"; };
                high = { reasoningEffort = "high"; description = "Architect Mode"; };
              };
            };
          };
        };
      };
    };
  };
}
