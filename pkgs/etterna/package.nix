{
  stdenv,
  lib,
  fetchurl,
  cmake,
  nasm,
  gtk2,
  glib,
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
  vulkan-headers,
  vulkan-loader,
  shaderc,
  glslang,
  spirv-tools,
}:
let
  version = "0.75.1";
in
stdenv.mkDerivation {
  pname = "etterna";
  name = "etterna-${version}";
  inherit version;

  src = fetchurl {
    url = "https://github.com/etternagame/etterna/archive/refs/tags/v${version}.tar.gz";
    hash = "sha256-3sTEzj7AQ/bY3O9FrK+Fd8iN21IhNqbP3rFzU5zBnc0=";
  };

  # Drop prebuilt ffmpeg 2.1.3 and Discord SDK blobs, video backgrounds fall back to Null
  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace-fail "set(SUPPORT_DISCORD_SDK ON)" "set(SUPPORT_DISCORD_SDK OFF)" \
      --replace-fail "target_link_libraries(Etterna PRIVATE ffmpeg)" "" \
      --replace-fail "SPIRV-Tools-opt)" "SPIRV-Tools-opt SPIRV-Tools)"
    sed -i '/^ *\(MachineIndependent\|OSDependent\|GenericCodeGen\)$/d' CMakeLists.txt
    sed -i '/^#error Something went wrong - Discord/d' src/Etterna/Singletons/GameState.cpp
    substituteInPlace extern/CMakeLists.txt \
      --replace-fail 'if(_proc STREQUAL "x86_64" AND UNIX AND NOT APPLE)' "if(FALSE)"
    substituteInPlace src/arch/CMakeLists.txt \
      --replace-fail 'elseif(''${CMAKE_SYSTEM_PROCESSOR} STREQUAL "x86_64") # Unix' "elseif(FALSE)"
    sed -i \
      -e '/extern\/ffmpeg\/linux-lib/,/DESTINATION/d' \
      -e '/libdiscord_partner_sdk.so"/,/DESTINATION/d' \
      CMake/Helpers/CPackSetup.cmake
  '';

  nativeBuildInputs = [
    cmake
    nasm
    pkg-config
  ];

  buildInputs = [
    gtk2
    glib
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
    vulkan-headers
    vulkan-loader
    shaderc.dev
    shaderc.static
    glslang
    spirv-tools.lib
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DGTK2_GDKCONFIG_INCLUDE_DIR=${gtk2.out}/lib/gtk-2.0/include"
    "-DGTK2_GLIBCONFIG_INCLUDE_DIR=${glib.out}/lib/glib-2.0/include"
    "-DWITH_CRASHPAD=OFF"
    "-DWITH_VULKAN_LINUX_EXTRAS=ON"
  ];

  # vk-bootstrap dlopens libvulkan at runtime
  postFixup = ''
    patchelf --add-rpath ${lib.makeLibraryPath [ vulkan-loader ]} $out/Etterna/Etterna
  '';

  meta = with lib; {
    homepage = "https://www.etterna.com/";
    description = "Advanced cross-platform rhythm game focused on keyboard play";
    platforms = [ "x86_64-linux" ];
    license = licenses.mit;
    maintainers = [ ];
  };
}
