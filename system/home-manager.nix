desktop: { lib, config, inputs, outputs, opt, ... }:{
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
      desktop = desktop.enable;
    };
  };
}
