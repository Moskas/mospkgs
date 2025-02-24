{
  lib,
  pkgs,
  ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "anifetch";
  version = "0.0.4";

  src = pkgs.fetchFromGitHub {
    owner = "Moskas";
    repo = "anifetch";
    rev = "d3400e84decf5d4f90eb229dfe12030104ac4bd3";
    hash = "sha256-skQZdOjBPHo1kJ+66dXmmH1p8VgxwHoYvJeF4ATZHlw=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-MZq7P158HUzqatdbgVUvF+0n8fenc2plqntRA/ZHFtM=";

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    openssl
  ];
  buildInputs = [ pkgs.openssl ];

  meta = with lib; {
    description = "
anifetch is like {neo,fast,p,uwu,one}fetch but for printing out user stats from anilist.co.";
    longDescription = ''
      anifetch is a small neofetch like application for printing anilist user stats
    '';
    homepage = "https://github.com/Moskas/anifetch";
    license = licenses.mit;
    mainProgram = "anifetch";
    maintainers = with maintainers; [ Moskas ];
    platforms = platforms.unix;
  };
}
