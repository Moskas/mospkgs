{
  lib,
  pkgs,
  ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "shinbun";
  version = "0.2.3";

  src = pkgs.fetchurl {
     url = "https://github.com/Moskas/shinbun/archive/refs/tags/v${version}.tar.gz";
     hash = "sha256-KTlB+Am4hRNMHiK+Wk6eLXh4elMFeIQhoyvPZCvvIts=";
  };

  cargoHash = "sha256-x68sQhlkgpq7DnpbsevwkJUecT3WB8itCoKs5yyRxr0=";

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    openssl
    sqlite
  ];
  buildInputs = with pkgs; [
    openssl
    sqlite
  ];

  meta = with lib; {
    description = "TUI rss/atom feed reader.";
    longDescription = ''
      shinbun (新聞) is a terminal-based RSS/Atom feed reader written in Rust, using ratatui and crossterm. It draws some inspiration from newsboat.
    '';
    homepage = "https://github.com/Moskas/shinbun";
    license = licenses.mit;
    mainProgram = "shinbun";
    maintainers = with maintainers; [ Moskas ];
    platforms = platforms.unix;
  };
}
