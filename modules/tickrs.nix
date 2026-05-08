{ lib, pkgs, ... }:

with lib;

let
  cfg = config.mospkgs.programs.tickrs;
in
{
  options.mospkgs.programs.tickrs = {
      symbols = mkOption {
        type = with types; listOf string;
        default = [
          "AMD"
          "NVDA"
          "INTC"
        ];
        description = "List of symbols to show in tickrs config";
      };

      time_frame = mkOption {
        type = types.str;
        default = "1W";
        description = "Time frame for tickrs chart";
      };

      show_volumes = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to show volumes in tickrs chart";
      };

      summary = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to show summary in tickrs chart";
      };

      chart_type = mkOption {
        type = types.str;
        default = "candle";
        description = "Chart type for tickrs";
      };
  };

  config = {
    home.xdg.configFile."tickrs/config.yml".source = pkgs.formats.yaml.generate "config" {
      symbols = cfg.symbols;
      time_frame = cfg.time_frame;
      show_volumes = cfg.show_volumes;
      summary = cfg.summary;
      chart_type = cfg.chart_type;
    };
  };
}
