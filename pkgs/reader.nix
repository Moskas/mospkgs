{
  lib,
  pkgs,
  ...
}:

let
  version = "0.5.0";
in

pkgs.buildGoModule {
  pname = "reader";
  inherit version;

  src = pkgs.fetchurl {
    url = "https://github.com/mrusme/reader/archive/refs/tags/v${version}.tar.gz";
    hash = "sha256-ds3ISgE+TsrVI08KvK75BbUCGj3E9yBE/bIPLeVlMJY=";
  };

  vendorHash = "sha256-8IjN7hm5Rg9ItkxE9pbnkVr5t+tG95W9vvXyGaWmEIA=";

  meta = with lib; {
    description = "reader is for your command line what the “readability” view is for modern browsers: A lightweight tool offering better readability of web pages on the CLI.";
    longDescription = ''reader is for your command line what the “readability” view is for modern browsers: A lightweight tool offering better readability of web pages on the CLI.'';
    license = licenses.gpl3Plus;
    maintainers = [ Moskas ];
    platforms = platforms.unix;
    mainProgram = "reader";
  };
}
