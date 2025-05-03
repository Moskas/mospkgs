self: super: {
  reader = super.callPackage ../pkgs/reader.nix { inherit self; };
  mpdnotify = super.callPackage ../pkgs/mpdnotify.nix { inherit self; };
  whdl = super.callPackage ../pkgs/whdl.nix { inherit self; };
  epy = super.callPackage ../pkgs/epy.nix { inherit self; };
  osu-bin = super.callPackage ../pkgs/osu-bin.nix { inherit self; };
  tickrs = super.callPackage ../pkgs/tickrs.nix { };
  zen-browser = super.callPackage ../pkgs/zen.nix { }.specific;
  etterna = super.callPackage ../pkgs/etterna/etterna.nix { };
  anifetch = super.callPackage ../pkgs/anifetch.nix { inherit self; };
  hakurei-reimu = super.callPackage ../pkgs/cursors/reimu.nix { };
}
