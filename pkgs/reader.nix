{
  lib,
  pkgs,
  ...
}:

let
  version = "0.4.5";
in

pkgs.buildGoModule {
  pname = "reader";
  inherit version;

  src = pkgs.fetchurl {
    url = "https://github.com/mrusme/reader/archive/refs/tags/v${version}.tar.gz";
    hash = "sha256-Knm0FaQ6hFCquwlFAJJPRk7SqMgTfGTsLFfFBsGRuB8=";
  };

  vendorHash = "sha256-obYdifg3WrTyxgN/VtzgpL31ZOyPNtVT8UDQts0WodQ=";

  meta = with lib; {
    description = "reader is for your command line what the “readability” view is for modern browsers: A lightweight tool offering better readability of web pages on the CLI.";
    longDescription = ''reader is for your command line what the “readability” view is for modern browsers: A lightweight tool offering better readability of web pages on the CLI.'';
    license = licenses.gpl3Plus;
    maintainers = [ Moskas ];
    platforms = platforms.unix;
    mainProgram = "reader";
  };
}
