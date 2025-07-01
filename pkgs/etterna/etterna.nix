{
  stdenv,
  lib,
  fetchurl,
  cmake,
  nasm,
  gtk2,
  glib,
  ffmpeg_4,
  alsa-lib,
  libmad,
  libogg,
  libvorbis,
  glew,
  libpulseaudio,
  udev,
  openssl,
  doxygen,
  pkg-config,
  libX11,
  libGLU,
  libGL,
  libXpm,
  libXext,
  libXxf86vm,
}:
let
  version = "0.74.4";
in
stdenv.mkDerivation {
  pname = "etterna";
  name = "etterna-${version}";
  inherit version;

  src = fetchurl {
    url = "https://github.com/etternagame/etterna/archive/refs/tags/v${version}.tar.gz";
    hash = "sha256-sivTxBOB2uS/DevmTiNABCYwS5uGEHfcKTOIWRP0vMQ=";
  };

  # patches = [
  #   ./0001-fix-build-with-ffmpeg-4.patch
  # ];

  # postPatch = ''
  #   sed '1i#include <ctime>' -i src/arch/ArchHooks/ArchHooks.h # gcc12
  # '';

  nativeBuildInputs = [
    cmake
    nasm
    pkg-config
  ];

  buildInputs = [
    gtk2
    glib
    ffmpeg_4
    alsa-lib
    libmad
    libogg
    libvorbis
    glew
    libpulseaudio
    udev
    openssl
    doxygen
    libX11
    libGLU
    libGL
    libXpm
    libXext
    libXxf86vm
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DWITH_SYSTEM_FFMPEG=1"
    "-DGTK2_GDKCONFIG_INCLUDE_DIR=${gtk2.out}/lib/gtk-2.0/include"
    "-DGTK2_GLIBCONFIG_INCLUDE_DIR=${glib.out}/lib/glib-2.0/include"
    "-DWITH_CRASHPAD=OFF"
  ];

  meta = with lib; {
    homepage = "https://www.etterna.com/";
    description = "Advanced cross-platform rhythm game focused on keyboard play";
    platforms = platforms.linux;
    license = licenses.mit;
    maintainers = [ ];
    broken = stdenv.isLinux && stdenv.isAarch64;
  };
}
