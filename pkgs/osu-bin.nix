{
  lib,
  pkgs,
  ...
}:
let
  pname = "osu-lazer-bin";
  version = "2025.816.0";

  src =
    {
      x86_64-linux = pkgs.fetchurl {
        url = "https://github.com/ppy/osu/releases/download/${version}-lazer/osu.AppImage";
        hash = "sha256-mOihQ8mtHEiq0FElkJiZl0mhBqPi8CoGowN358Jc72A=";
      };
    }
    .${pkgs.stdenv.system} or (throw "${pname}-${version}: ${pkgs.stdenv.system} is unsupported.");

  meta = {
    description = "Rhythm is just a *click* away (AppImage version for score submission and multiplayer, and binary distribution for Darwin systems)";
    homepage = "https://osu.ppy.sh";
    license = with lib.licenses; [
      mit
      cc-by-nc-40
      unfreeRedistributable # osu-framework contains libbass.so in repository
    ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [
      Moskas
    ];
    mainProgram = "osu!";
    platforms = [
      "x86_64-linux"
    ];
  };

  passthru.updateScript = ./update-bin.sh;
in
if pkgs.stdenv.isDarwin then
  pkgs.stdenv.mkDerivation {
    inherit
      pname
      version
      src
      meta
      passthru
      ;

    installPhase = ''
      runHook preInstall
      APP_DIR="$out/Applications"
      mkdir -p "$APP_DIR"
      cp -r . "$APP_DIR"
      runHook postInstall
    '';
  }
else
  pkgs.appimageTools.wrapType2 {
    inherit
      pname
      version
      src
      meta
      passthru
      ;

    extraPkgs = pkgs: with pkgs; [ icu ];

    extraInstallCommands =
      let
        contents = pkgs.appimageTools.extract { inherit pname version src; };
      in
      ''
        mv -v $out/bin/${pname} $out/bin/osu\!
        install -m 444 -D ${contents}/osu\!.desktop -t $out/share/applications
        for i in 16 32 48 64 96 128 256 512 1024; do
          install -D ${contents}/osu.png $out/share/icons/hicolor/''${i}x$i/apps/osu.png
        done
      '';
  }
