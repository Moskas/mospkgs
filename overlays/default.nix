final: prev: {
  reader = prev.callPackage ../pkgs/reader.nix { };
  mpdnotify = prev.callPackage ../pkgs/mpdnotify.nix { };
  whdl = prev.callPackage ../pkgs/whdl.nix { };
  epy = prev.callPackage ../pkgs/epy.nix { };
  osu-bin = prev.callPackage ../pkgs/osu-bin.nix { };
  tickrs = prev.callPackage ../pkgs/tickrs.nix { };
  zen-browser = prev.callPackage ../pkgs/zen.nix { }.specific;
  etterna = prev.callPackage ../pkgs/etterna/etterna.nix { };
  anifetch = prev.callPackage ../pkgs/anifetch.nix { };
  hakurei-reimu = prev.callPackage ../pkgs/cursors/reimu.nix { };
  haru-urara = prev.callPackage ../pkgs/cursors/haru.nix { };
}
