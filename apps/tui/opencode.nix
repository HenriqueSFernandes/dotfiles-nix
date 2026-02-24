{ ... }:
{
  programs.opencode = {
    enable = true;
    settings = {
      provider = {
        anthropic = {
          options = {
            timeout = 600000;
            setCacheKey = true;
          };
        };
      };
      model = "copilot:claude-4.6-sonnet";
      small_model = "copilot:claude-4-5-haiku";
    };
  };
}
