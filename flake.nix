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
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      inherit (nixpkgs) lib;

      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
          # Required for packages such as osu-bin
          config.allowUnfree = true;
        };

      # Build all packages for a system, filtered to those whose meta.platforms includes it.
      # Packages without meta.platforms are included on all systems.
      packagesForSystem =
        system:
        let
          pkgs = pkgsFor system;
          allPkgs = import ./pkgs { inherit pkgs; };
        in
        lib.filterAttrs (_: drv: builtins.elem system (drv.meta.platforms or [ system ])) allPkgs;
    in
    {
      packages = lib.genAttrs systems packagesForSystem;

      devShells = lib.genAttrs systems (system: {
        default = (pkgsFor system).mkShell {
          name = "mospkgs dev shell";
          packages = with (pkgsFor system); [
            cachix
            nurl
          ];
        };
      });

      overlays.default = import ./overlays;

      formatter = lib.genAttrs systems (system: (pkgsFor system).nixfmt-tree);
    };
}
