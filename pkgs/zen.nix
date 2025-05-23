{ pkgs, ... }:
# Most of the code is from https://github.com/MarceColl/zen-browser-flake
let
  version = "1.11.1b";
  downloadUrl = {
    "specific" = {
      url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-x86_64.tar.xz";
      sha256 = "sha256:1haf3cki579jmwpdrmkixzslaaxajk5wj2p6sjrmghci1s6gz8cy";
    };
  };

  runtimeLibs =
    with pkgs;
    [
      libGL
      libGLU
      libevent
      libffi
      libjpeg
      libpng
      libstartup_notification
      libvpx
      libwebp
      stdenv.cc.cc
      fontconfig
      libxkbcommon
      zlib
      freetype
      gtk3
      libxml2
      dbus
      xcb-util-cursor
      alsa-lib
      libpulseaudio
      pango
      atk
      cairo
      gdk-pixbuf
      glib
      udev
      libva
      mesa
      libnotify
      cups
      pciutils
      ffmpeg
      libglvnd
      pipewire
    ]
    ++ (with pkgs.xorg; [
      libxcb
      libX11
      libXcursor
      libXrandr
      libXi
      libXext
      libXcomposite
      libXdamage
      libXfixes
      libXScrnSaver
    ]);

  mkZen =
    { variant }:
    let
      downloadData = downloadUrl."${variant}";
    in
    pkgs.stdenv.mkDerivation {
      inherit version;
      pname = "zen-browser";

      src = builtins.fetchTarball {
        url = downloadData.url;
        sha256 = downloadData.sha256;
      };

      desktopSrc = ./.;

      phases = [
        "installPhase"
        "fixupPhase"
      ];

      nativeBuildInputs = [
        pkgs.makeWrapper
        pkgs.copyDesktopItems
        pkgs.wrapGAppsHook
      ];

      installPhase = ''
        mkdir -p $out/bin && cp -r $src/* $out/bin
        mkdir -p $out/share/applications

        cat << EOF > $out/share/applications/zen-browser.desktop
        [Desktop Entry]
        Name=Zen Browser
        Exec=zen %u
        Icon=zen
        Type=Application
        MimeType=text/html;text/xml;application/xhtml+xml;x-scheme-handler/http;x-scheme-handler/https;application/x-xpinstall;application/pdf;application/json;
        StartupWMClass=zen-alpha
        Categories=Network;WebBrowser;
        StartupNotify=true
        Terminal=false
        X-MultipleArgs=false
        Keywords=Internet;WWW;Browser;Web;Explorer;
        Actions=new-window;new-private-window;profilemanager;

        [Desktop Action new-window]
        Name=Open a New Window
        Exec=zen %u

        [Desktop Action new-private-window]
        Name=Open a New Private Window
        Exec=zen --private-window %u

        [Desktop Action profilemanager]
        Name=Open the Profile Manager
        Exec=zen --ProfileManager %u
        EOF
        install -D $src/browser/chrome/icons/default/default128.png $out/share/icons/hicolor/128x128/apps/zen.png
      '';

      fixupPhase = ''
        chmod 755 $out/bin/*
        patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/zen
        wrapProgram $out/bin/zen --set LD_LIBRARY_PATH "${pkgs.lib.makeLibraryPath runtimeLibs}" \
                          --set MOZ_LEGACY_PROFILES 1 --set MOZ_ALLOW_DOWNGRADE 1 --set MOZ_APP_LAUNCHER zen --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH"
        patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/zen-bin
        wrapProgram $out/bin/zen-bin --set LD_LIBRARY_PATH "${pkgs.lib.makeLibraryPath runtimeLibs}" \
                          --set MOZ_LEGACY_PROFILES 1 --set MOZ_ALLOW_DOWNGRADE 1 --set MOZ_APP_LAUNCHER zen --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH"
        patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/glxtest
        wrapProgram $out/bin/glxtest --set LD_LIBRARY_PATH "${pkgs.lib.makeLibraryPath runtimeLibs}"
        patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/updater
        wrapProgram $out/bin/updater --set LD_LIBRARY_PATH "${pkgs.lib.makeLibraryPath runtimeLibs}"
        patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/vaapitest
        wrapProgram $out/bin/vaapitest --set LD_LIBRARY_PATH "${pkgs.lib.makeLibraryPath runtimeLibs}"
      '';

      meta.mainProgram = "zen";
    };
in
{
  generic = mkZen { variant = "generic"; };
  specific = mkZen { variant = "specific"; };
}
