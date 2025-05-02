{
  pkgs,
  system,
  inputs,
  lib,
  ...
}:
{
  "x86_64-linux" = {
    reader = import ./reader.nix {
      inherit
        pkgs
        system
        inputs
        lib
        ;
    };
    mpdnotify = import ./mpdnotify.nix {
      inherit
        pkgs
        system
        inputs
        lib
        ;
    };
    whdl = import ./whdl.nix {
      inherit
        pkgs
        system
        inputs
        lib
        ;
    };
    epy = import ./epy.nix {
      inherit
        pkgs
        lib
        system
        inputs
        ;
    };
    osu-bin = import ./osu-bin.nix {
      inherit pkgs lib;
    };
    tickrs = (pkgs.callPackage ./tickrs.nix { });
    zen-browser = (pkgs.callPackage ./zen.nix { }).specific;
    etterna = (pkgs.callPackage ./etterna/etterna.nix { });
    aporetic-sans-mono = (pkgs.callPackage ./fonts/aporetic.nix { });
    anifetch = import ./anifetch.nix {
      inherit
        pkgs
        lib
        system
        inputs
        ;
    };
    nyxt = (pkgs.callPackage ./nyxt { });
    hakurei-reimu = (pkgs.callPackage ./cursors/reimu.nix { });
  };
}
