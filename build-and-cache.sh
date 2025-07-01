#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'  # safer word splitting

# Get all package names from the flake
packages=$(nix flake show --json | nix run nixpkgs#jq -- -r '.packages | to_entries[] | .value | keys[]')

# Iterate over each package and build it
for pkg in $packages; do
  echo "Building package: $pkg"
  #nix build ".#$pkg"
  nix build --no-link --print-out-paths ".#$pkg" | cachix push moskas
  echo "Finished building: $pkg"
done

