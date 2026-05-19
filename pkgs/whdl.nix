{
  lib,
  pkgs,
  ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "whdl";
  version = "0.2.0";

  src = pkgs.fetchFromGitHub {
    owner = "Moskas";
    repo = "whdl";
    rev = "d0885dfe09bb85a6dae5bc7efaf7b8ff9d435ab0";
    hash = "sha256-CiIOZvSMxRkpO6Tgagj7kxRxLU9NzAuhOht9MO5M5/g=";
  };

  cargoHash = "sha256-ehs2w+kD0pFhATSEk4VGlCYcqQxLcWV8fWbDglEavPU=";

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
