self: super: {
  reader = super.callPackage ./reader.nix { inherit self; };
  mpdnotify = super.callPackage ./mpdnotify.nix { inherit self; };
  whdl = super.callPackage ./whdl.nix { inherit self; };
  epy = super.callPackage ./epy.nix { inherit self; };
  osu-bin = super.callPackage ./osu-bin.nix { inherit self; };
  tickrs = super.callPackage ./tickrs.nix { };
  zen-browser = super.callPackage ./zen.nix { }.specific;
  etterna = super.callPackage ./etterna/etterna.nix { };
  anifetch = super.callPackage ./anifetch.nix { inherit self; };
}
