{
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation {
  pname = "hakurei-reimu";
  version = "1.0";

  src = ./Hakurei-Reimu.tar.gz;

  installPhase = ''
    runHook preInstall
    tar xzf $src
    mkdir -p $out/share/icons
    cp -R "Hakurei Reimu" $out/share/icons/
    runHook postInstall
  '';

  meta = with lib; {
    description = "Hakurei Reimu Cursor";
    downloadPage = "https://www.pling.com/p/2219957";
    maintainers = with maintainers; [ Moskas ];
    license = licenses.unlicense;
  };
}
