{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.mospkgs.programs.etterna;

  # Etterna resolves its root from the executable path and needs it writable, so the binary
  # is copied into dataDir and the read-only game data is symlinked from the store
  launcher = pkgs.writeShellApplication {
    name = "etterna";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.findutils
    ];
    text = ''
      root=${escapeShellArg cfg.dataDir}
      store=${cfg.package}/Etterna

      link() {
        if [[ -e $2 && ! -L $2 ]]; then
          echo "etterna: $2 exists and is not a symlink, leaving it in place" >&2
        else
          ln -sfn "$1" "$2"
        fi
      }

      # Real directories with per-entry links, so users can add their own themes and noteskins
      linkEntries() {
        local entry
        mkdir -p "$2"
        for entry in "$1"/*; do
          if (( $3 > 1 )) && [[ -d $entry ]]; then
            linkEntries "$entry" "$2/''${entry##*/}" $(($3 - 1))
          else
            link "$entry" "$2/''${entry##*/}"
          fi
        done
      }

      mkdir -p "$root"/{Cache,Logs,Save,Songs}

      # Drop links left over from previous package versions
      find "$root" -maxdepth 3 -path "$root/Songs" -prune -o \
        -type l -lname '/nix/store/*' ! -lname "$store/*" -exec rm {} +

      for entry in "$store"/*; do
        name=''${entry##*/}
        case $name in
          Etterna | Songs) ;;
          Themes) linkEntries "$entry" "$root/$name" 1 ;;
          NoteSkins) linkEntries "$entry" "$root/$name" 2 ;;
          *) link "$entry" "$root/$name" ;;
        esac
      done

      if [[ "$(cat "$root/.store-path" 2>/dev/null)" != "$store" ]]; then
        install -m755 "$store/Etterna" "$root/Etterna.tmp"
        mv -f "$root/Etterna.tmp" "$root/Etterna"
        echo "$store" >"$root/.store-path"
      fi

      export ETTERNA_ROOT_DIR="$root"
      exec "$root/Etterna" "$@"
    '';
  };
in
{
  options.mospkgs.programs.etterna = {
    enable = mkEnableOption "Etterna rhythm game";
    package = mkOption {
      type = types.package;
      default = pkgs.callPackage ../pkgs/etterna/package.nix { };
      defaultText = literalMD "the `etterna` package from mospkgs";
      description = "Etterna package to use";
    };
    dataDir = mkOption {
      type = types.str;
      default = "${config.xdg.dataHome}/etterna";
      defaultText = literalExpression ''"''${config.xdg.dataHome}/etterna"'';
      description = "Writable install directory holding songs, saves, logs and cache";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [ launcher ];
    xdg.desktopEntries.etterna = {
      name = "Etterna";
      comment = "Advanced cross-platform rhythm game focused on keyboard play";
      exec = "etterna";
      icon = "${../pkgs/etterna/icon.png}";
      categories = [ "Game" ];
    };
  };
}
