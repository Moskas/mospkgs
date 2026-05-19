{
  lib,
  pkgs,
  ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "shinbun";
  version = "0.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "Moskas";
    repo = "shinbun";
    rev = "1c360b387146b62ecb3787d91d7cd631461f4490";
    hash = "sha256-+zS/2NzLS/CJZeWvgpUX5dZWpd4fflbbfLAyS4D+Mjs=";
  };

  cargoHash = "sha256-7aRDxxEcyOoLVf28frJ5PPze7ZKa5OKFxTPqeWYHxhY=";

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    openssl
    sqlite
  ];
  buildInputs = [
    pkgs.openssl
    pkgs.sqlite
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
