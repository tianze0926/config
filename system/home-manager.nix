{ config, inputs, outputs, opt, ... }:
let
  cfg = config.custom.desktop;
in {

  config.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${opt.user}" = import ../home;
    extraSpecialArgs = {
      inherit inputs outputs opt;
      desktop = cfg.enable;
    };
  };
}
