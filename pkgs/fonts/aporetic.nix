{
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
  pname = "aporetic-sans-mono";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "protesilaos";
    repo = "aporetic";
    rev = "b766055c10036bc166e44e8564d441fd3c72e637";
    hash = "sha256-5m4iT77FFsJf6N1FIsCtk5Z0IEOVUGCceXiT2n5dZUg=";
  };

  installPhase = ''
    runHook preInstall
    install -Dm644 -t $out/share/fonts/truetype/ $src/aporetic-sans-mono/TTF/*.ttf
    runHook postInstall
  '';
}
