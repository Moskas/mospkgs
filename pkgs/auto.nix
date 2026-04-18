# Auto-discovers packages in this directory.
# - Flat .nix files (excluding default.nix and this file) → name is the filename stem
# - Subdirectories containing a package.nix → name is the directory name
let
  dir = builtins.readDir ./.;
  names = builtins.attrNames dir;
  stripNix = name: builtins.substring 0 (builtins.stringLength name - 4) name;

  flatPkgs = builtins.listToAttrs (
    map
      (name: {
        name = stripNix name;
        value = ./. + "/${name}";
      })
      (
        builtins.filter (
          name:
          dir.${name} == "regular"
          && builtins.match ".*\\.nix" name != null
          && !(builtins.elem name [
            "default.nix"
            "auto.nix"
          ])
        ) names
      )
  );

  dirPkgs = builtins.listToAttrs (
    map
      (name: {
        inherit name;
        value = ./. + "/${name}/package.nix";
      })
      (
        builtins.filter (
          name: dir.${name} == "directory" && builtins.pathExists (./. + "/${name}/package.nix")
        ) names
      )
  );
in
flatPkgs // dirPkgs
