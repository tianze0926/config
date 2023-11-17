{ lib, ... }: {
  options.custom.desktop.enable = lib.mkEnableOption "Enable Desktop";

  # conditionally import modules based on config options
  # while preventing infinite recursion
  imports = let
    condition = config: config.custom.desktop.enable;
  in builtins.map (path: rec {
    function = import path;
    wrappedFunction = args@{ lib, config, ... }:
      lib.mkIf (condition config) (function args);
    # preserve the original function's args declaration
    # so that the module system would pass lazy args such as `pkgs`
    argsDeclaredFunction = lib.setFunctionArgs
      wrappedFunction (lib.functionArgs function);
  }.argsDeclaredFunction) [
    ./display.nix
    ./fonts.nix
    ./fcitx5.nix
    ./media.nix
  ];

}
