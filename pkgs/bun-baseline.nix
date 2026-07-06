{ pkgs, fetchurl, ... }:
pkgs.bun.overrideAttrs (oldAttrs: {
  pname = "bun-baseline";
  src = fetchurl {
    url = "https://github.com/oven-sh/bun/releases/download/bun-v${oldAttrs.version}/bun-linux-x64-baseline.zip";
    hash = "sha256-KB5sutlp6y9e9XJMbLoB2kDNX+rW+CksUO1gvU26eK4=";
  };
  meta = oldAttrs.meta // {
    description = oldAttrs.meta.description + " (baseline build for pre-Haswell/AVX2 CPUs)";
    platforms = [ "x86_64-linux" ];
  };
})
