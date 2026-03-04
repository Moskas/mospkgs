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
  rev = "25c34b42f10a979b03c7f8804323a8e12eeda77a";
  hash = "sha256-LqRQb0I1Mk2uLcWkDnFgF2GVr9MHm/VToTmdjopYniQ=";
};

  cargoHash = "sha256-jyScmaYuHDvHZuyVLGjoIy/gsSej6sI/J0qTvdYS8tg=";

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    openssl
    sqlite
  ];
  buildInputs = [ pkgs.openssl pkgs.sqlite ];

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
