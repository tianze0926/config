{ pkgs, opt, ... }: {
  users.users.${opt.user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.fish;
  };

  security.sudo.extraConfig = ''
    ${opt.user} ALL=(ALL) NOPASSWD:ALL
  '';

  nix.settings.trusted-users = [ opt.user ];

}
