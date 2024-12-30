{ pkgs, ... }:
pkgs.writeShellScriptBin "install-etterna" ''
  homeDir="/home/$3"
  installDir="$homeDir/.local/share/Etterna"
  applicationsDir="$homeDir/.local/share/applications"

  if [[ ! -f "$installDir/Etterna" ]]; then
    ${pkgs.coreutils}/bin/echo "\$1: $1"
    ${pkgs.coreutils}/bin/echo "\$2: $2"
    ${pkgs.coreutils}/bin/echo "\$3: $3"
    ${pkgs.coreutils}/bin/cp -r "$1/Etterna" "$installDir"
    ${pkgs.coreutils}/bin/mkdir "$homeDir/.etterna"
    ${pkgs.coreutils}/bin/mkdir "$homeDir/.etterna/Save"
    ${pkgs.coreutils}/bin/mv "$installDir/Announcers" "$homeDir/.etterna"
    ${pkgs.coreutils}/bin/mv "$installDir/Assets" "$homeDir/.etterna"
    ${pkgs.coreutils}/bin/mv "$installDir/NoteSkins" "$homeDir/.etterna"
    ${pkgs.coreutils}/bin/mv "$installDir/Songs" "$homeDir/.etterna"
    ${pkgs.coreutils}/bin/mv "$installDir/Themes" "$homeDir/.etterna"
  else
    ${pkgs.coreutils}/bin/rm -rf "$installDir"
    ${pkgs.coreutils}/bin/cp -r "$1/Etterna" "$installDir"
    ${pkgs.coreutils}/bin/rm -rf "$installDir/Announcers"
    ${pkgs.coreutils}/bin/rm -rf "$installDir/Assets"
    ${pkgs.coreutils}/bin/rm -rf "$installDir/NoteSkins"
    ${pkgs.coreutils}/bin/rm -rf "$installDir/Songs"
    ${pkgs.coreutils}/bin/rm -rf "$installDir/Themes"
  fi

  ${pkgs.coreutils}/bin/ln -s "$homeDir/.etterna/Announcers" "$installDir"
  ${pkgs.coreutils}/bin/ln -s "$homeDir/.etterna/Assets" "$installDir"
  ${pkgs.coreutils}/bin/ln -s "$homeDir/.etterna/NoteSkins" "$installDir"
  ${pkgs.coreutils}/bin/ln -s "$homeDir/.etterna/Save" "$installDir"
  ${pkgs.coreutils}/bin/ln -s "$homeDir/.etterna/Songs" "$installDir"
  ${pkgs.coreutils}/bin/ln -s "$homeDir/.etterna/Themes" "$installDir"

  if [[ -f "$applicationsDir/etterna.desktop" ]]; then
    ${pkgs.coreutils}/bin/rm "$applicationsDir/etterna.desktop"
  fi

  ${pkgs.coreutils}/bin/cp "$2" "$applicationsDir/etterna.desktop"
  ${pkgs.coreutils}/bin/chown "$3" "$applicationsDir/etterna.desktop"
  ${pkgs.coreutils}/bin/chmod 755 "$applicationsDir/etterna.desktop"
  ${pkgs.coreutils}/bin/echo "Exec=$installDir/Etterna" >> "$applicationsDir/etterna.desktop"
  ${pkgs.coreutils}/bin/echo "Icon=$homeDir/.local/share/icons/etterna.png" >> "$applicationsDir/etterna.desktop"

  ${pkgs.coreutils}/bin/chown -R "$3":users "$homeDir/.etterna"
  ${pkgs.coreutils}/bin/chmod -R 755 "$homeDir/.etterna"

  ${pkgs.coreutils}/bin/mkdir "$installDir/Cache"
  ${pkgs.coreutils}/bin/chown -R "$3":users "$installDir/Cache"
  ${pkgs.coreutils}/bin/chmod -R 755 "$installDir/Cache"

''
