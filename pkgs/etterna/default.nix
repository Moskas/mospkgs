{
  pkgs,
  config,
  lib,
  ...
}:
let
  etterna = pkgs.callPackage ./etterna.nix { };
  script = pkgs.callPackage ./install.nix { };
  desktopFile = ./etterna.desktop;
in
{
  options = {
    program.etterna.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf config.program.etterna.enable {
    home.packages = [
      etterna
      script
    ];
    home.file = {
      ".local/share/icons/etterna.png".source = ./icon.png;
      ".local/share/applications/Etterna.desktop".source = desktopFile;
    };
    #systemd.user.services.etterna-local-install = {
    #  Unit = {
    #    Description = "Install Etterna locally";
    #  };
    #  Service = {
    #    Type = "oneshot";
    #    ExecStart = "${pkgs.bash}/bin/bash ${script}/bin/install-etterna ${etterna} ${desktopFile} ${config.home.username}";
    #  };
    #  Install = {
    #    WantedBy = [ "default.target" ];
    #  };
    #};
  };
}
