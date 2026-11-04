# TEMPORARY workaround for NixOS/nixpkgs#578265 (python3Packages.posthog: unbreak).
# nixpkgs#575004 bumped mcp 1.29 -> 2.2 and marked python3Packages.posthog broken;
# the only failure is one test in posthog's optional MCP integration (field rename
# in mcp 2). open-webui indirectly depends on posthog via chromadb, so evaluation
# fails without this.
#
# Remove once `nix flake update` pulls the PR in: delete this file and the
# corresponding entry in system/configuration.nix (grep 578265).
_final: prev:
let
  inherit (prev) lib;
in
{
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (_pyFinal: pyPrev: {
      posthog =
        if !pyPrev.posthog.meta.broken then
          lib.warn
            "nixpkgs no longer marks posthog broken: NixOS/nixpkgs#578265 has landed, remove overlays/posthog-unbreak.nix"
            pyPrev.posthog
        else
          pyPrev.posthog.overridePythonAttrs (old: {
            disabledTests = old.disabledTests ++ [
              # AttributeError: 'CallToolResult' object has no attribute 'structuredContent'
              # (mcp>=2 renamed the field to `structured_content`)
              "test_prepare_tool_result_delivers_into_call_tool_result_models"
            ];
            meta = old.meta // {
              broken = false;
            };
          });
    })
  ];
}
