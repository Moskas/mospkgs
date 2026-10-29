#!/usr/bin/env bash
# Builds flake checks (packages built from source) that are not yet in Cachix and pushes them.
# Usage: ./build-and-cache.sh [--no-push]
set -euo pipefail

export NIX_CONFIG="experimental-features = nix-command flakes"

args=(--flake ".#checks.${SYSTEM:-x86_64-linux}" --skip-cached --no-nom)
[[ "${1:-}" == "--no-push" ]] || args+=(--cachix-cache "${CACHIX_CACHE:-moskas}")

nix run nixpkgs#nix-fast-build -- "${args[@]}"
