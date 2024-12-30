{
  description = "Moskas' Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      inherit (nixpkgs) lib;
    in
    {
      packages = import ./pkgs {
        inherit
          pkgs
          system
          inputs
          lib
          ;
      };
    };
}
