{
  description = "Moskas' packages and modules flake";

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
      pkgs = import nixpkgs {
        inherit system;
        # Need for packages such as osu-bin
        config.allowUnfree = true;
      };
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
      devShells.${system}.default = pkgs.mkShell {
        name = "mospkgs dev shell";
        packages = with pkgs; [
          cachix
        ];
      };
      overlays.default = import ./overlays;
      formatter."${system}" = pkgs.nixfmt-rfc-style;
    };
}
