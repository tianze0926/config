{ lib, config, inputs, outputs, opt, ... }:
let
  cfg = config.custom.desktop;
in {

  options.hm = with lib; mkOption {
    default = [];
    type = types.listOf (types.functionTo types.attrs);
  };

  config.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${opt.user}" = import ../home;
    extraSpecialArgs = {
      inherit inputs outputs opt;
      configSys = config.hm;
      desktop = cfg.enable;
    };
  };
}
