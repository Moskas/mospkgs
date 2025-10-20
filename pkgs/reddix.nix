{
  lib,
  pkgs,
  ...
}:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "reddix";
  version = "0.2.3";

  src = pkgs.fetchurl {
    url = "https://github.com/ck-zhang/reddix/archive/refs/tags/v${version}.tar.gz";
    hash = "sha256-x/X8mesyb9oF2Yx+hp8rfpQWY7J8zvOyPJuFlMAoUAg=";
  };

  # useFetchCargoVendor = true;
  cargoHash = "sha256-8YKh5OuqwqetZiCZ481I0JOFkrz/eTj/EqmR1eXhTzg=";

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    openssl
  ];
  buildInputs = [ pkgs.openssl ];

  meta = with lib; {
    description = "Reddix - Reddit, refined for the terminal.";
    longDescription = ''
      Reddix - Reddit, refined for the terminal.
    '';
    homepage = "https://github.com/ck-zhang/reddix";
    license = licenses.mit;
    mainProgram = "reddix";
    maintainers = with maintainers; [ Moskas ];
    platforms = platforms.unix;
  };
}
