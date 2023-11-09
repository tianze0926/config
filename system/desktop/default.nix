args@{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.custom.desktop;
in {
  options.custom.desktop.enable = mkEnableOption "Enable Desktop";

  # a workaround for infinite recursion when conditionally importing modules
  config = mkMerge (builtins.map (
    path: mkIf cfg.enable (import path args)
  ) [
    ./display.nix
    ./fonts.nix
    ./fcitx5.nix
    ./media.nix
  ]);

}
