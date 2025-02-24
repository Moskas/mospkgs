{
  lib,
  pkgs,
  ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "whdl";
  version = "0.1.1";

  src = pkgs.fetchFromGitHub {
    owner = "Moskas";
    repo = "whdl";
    rev = "e23f3ef0e52c144039e669726835a43507e8b2cf";
    hash = "sha256-snV/jTn6YagfYH+u7YJB0R5tUQWg5D5UQQPZtjzbQR8=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-X02+IL7RuEFmIYSSBgYNH1ZAMlkRiFdLg8ySUrynCOQ=";

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    openssl
  ];
  buildInputs = [ pkgs.openssl ];

  meta = with lib; {
    description = "wallhaven.cc batch downloader written in Rust";
    longDescription = ''
      Simple wallhaven.cc wallpaper downloader written in Rust.
    '';
    homepage = "https://github.com/Moskas/whdl";
    license = licenses.mit;
    mainProgram = "whdl";
    maintainers = with maintainers; [ Moskas ];
    platforms = platforms.unix;
  };
}
