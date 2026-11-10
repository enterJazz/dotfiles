{ pkgs, lib, ... }:
let
  base = "https://downloads.claude.ai/claude-code-releases";

  # Fallback / offline manifest, refreshed with `just claude-update`.
  pinned = lib.importJSON ./claude-code/manifest.json;

  # Newest upstream release, looked up at evaluation time. Needs --impure
  # (which `just pc` always passes) and network access.
  latestVersion = lib.trim (builtins.readFile (builtins.fetchurl "${base}/latest"));
  latest = lib.importJSON (builtins.fetchurl "${base}/${latestVersion}/manifest.json");

  # `CLAUDE_CODE_PINNED=1 just pc` uses the vendored manifest (e.g. offline).
  manifest = if builtins.getEnv "CLAUDE_CODE_PINNED" != "" then pinned else latest;
in
{
  # nixpkgs' derivation, pointed at the newest upstream release.
  home.packages = [ (pkgs.claude-code.override { inherit manifest; }) ];
}
