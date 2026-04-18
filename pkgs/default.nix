{ pkgs, ... }:
let
  packagePaths = import ./auto.nix;
in
builtins.mapAttrs (_: path: pkgs.callPackage path { }) packagePaths
