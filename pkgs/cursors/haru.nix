{
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation {
  pname = "haru-urara";
  version = "1.0";

  src = ./Haru;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons/Haru
    cp -R $src/* $out/share/icons/Haru
    runHook postInstall
  '';

  meta = with lib; {
    description = "Haru Urara Animated Cursor by pixloen";
    downloadPage = "https://ko-fi.com/s/e93c7071f6";
    maintainers = with maintainers; [ Moskas ];
    license = licenses.unlicense;
  };
}
