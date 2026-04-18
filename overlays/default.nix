let
  packagePaths = import ../pkgs/auto.nix;
in
final: prev: builtins.mapAttrs (_: path: prev.callPackage path { }) packagePaths
