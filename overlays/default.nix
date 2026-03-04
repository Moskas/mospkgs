final: prev:
let
  # Import and evaluate the pkgs/default.nix file relative to overlay location
  customPkgs = import ../pkgs { inherit (prev) callPackage lib stdenv; };
in
# Merge packages into final set (prev takes precedence on conflicts)
customPkgs // final
