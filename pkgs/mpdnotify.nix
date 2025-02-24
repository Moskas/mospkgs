{
  lib,
  pkgs,
  ...
}:

pkgs.stdenv.mkDerivation pkgs.rustPlatform.buildRustPackage rec {
  pname = "mpd-notify-rs";
  version = "0.1.3";

  src = pkgs.fetchFromGitHub {
    owner = "Moskas";
    repo = "mpd-notify-rs";
    rev = "38792935b3f15bb7fdb75c3f507a57277a70f6fa";
    hash = "sha256-VCJsbVvSNcExduk245LUW+pX+kpzVFEVaHtSVgVHEaI=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-yTQx4RRf6wVrP3NWCwoeNqTsKDj0SerelZ9I8/wzn3o=";

  nativeBuildInputs = [ ];
  buildInputs = [ ];

  meta = with lib; {
    description = "MPD notification daemon";
    longDescription = ''
      MPD notification daemon written in Rust.
    '';
    homepage = "https://github.com/Moskas/mpd-notify-rs";
    license = licenses.mit;
    mainProgram = "mpd-notify-rs";
    maintainers = with maintainers; [ Moskas ];
    platforms = platforms.unix;
  };
}
