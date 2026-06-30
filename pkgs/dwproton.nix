{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "dwproton";
  version = "11.0-5";

  src = fetchurl {
    url = "https://dawn.wine/dawn-winery/dwproton/releases/download/dwproton-${finalAttrs.version}/dwproton-${finalAttrs.version}-x86_64.tar.xz";
    hash = "sha256-GLXwUswB/uJEFWlij5KN9MUE483QOdvkTbKvEtk8VZI=";
  };

  sourceRoot = "dwproton-${finalAttrs.version}-x86_64";

  installPhase = ''
    runHook preInstall
    mkdir -p "$out"
    cp -r . "$out/"
    runHook postInstall
  '';

  meta = {
    description = "Dawn Winery's custom Wine-based Proton build (CachyOS fork) for Steam";
    homepage = "https://dawn.wine/dawn-winery/dwproton";
    license = lib.licenses.unfreeRedistributable;
    maintainers = with lib.maintainers; [ Moskas ];
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
})
