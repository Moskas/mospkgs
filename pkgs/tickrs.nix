{ pkgs, ... }:
pkgs.tickrs.overrideAttrs (oldAttrs: {
  patches = (oldAttrs.patches or [ ]) ++ [ ./tickrs-vim.patch ];
})
