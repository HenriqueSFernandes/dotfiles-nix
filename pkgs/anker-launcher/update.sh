#!/usr/bin/env bash
set -euo pipefail

# Auto-update anker-launcher to the latest upstream GitHub release.
# Run from the package directory:
#   cd pkgs/anker-launcher
#   ./update.sh

repo="zororver/anker-launcher"
scriptDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
nixFile="${scriptDir}/default.nix"

latestTag=$(curl -s "https://api.github.com/repos/${repo}/releases/latest" | jq -r '.tag_name')
version="${latestTag#v}"

assetUrl="https://github.com/${repo}/releases/download/${latestTag}/AnkerLauncher-${version}-x86_64.AppImage"

echo "Fetching Anker Launcher ${version} ..."
newHash=$(nix-prefetch-url --name "AnkerLauncher-${version}-x86_64.AppImage" "${assetUrl}")
newHash=$(nix-hash --to-sri --type sha256 "${newHash}")

echo "Updating ${nixFile} ..."
sed -i \
  -e "s|version = \"[^\"]*\";|version = \"${version}\";|" \
  -e "s|hash = \"sha256-[^\"]*\";|hash = \"${newHash}\";|" \
  "${nixFile}"

echo "Done. New version: ${version} / ${newHash}"
