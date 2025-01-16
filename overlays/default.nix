final: prev: {
  inherit
    (import ../pkgs/default.nix {
      pkgs = prev;
      system = builtins.currentSystem;
      inputs = { };
      lib = prev.lib;
    })
    reader
    mpdnotify
    whdl
    epy
    osu-bin
    tickrs
    zen-browser
    etterna
    anifetch
    ;
}
