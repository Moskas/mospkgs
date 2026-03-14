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
    rev = "b01f26e23ab09f57a0e927e5effbe2e746ff6d42";
    hash = "sha256-JznUPzeulk5M+dhLp9hlZsEH8S724oMDyWzpPRGnZkY=";
  };

  cargoHash = "sha256-bwOKidxahdETbqRns0KzeuAhkNSHFHhoOTjZsTOIMoY=";

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
