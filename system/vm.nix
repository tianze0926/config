{ pkgs, opt, ...}: {
  virtualisation.libvirtd.enable = true;
  users.users."${opt.user}".extraGroups = [ "libvirtd" ];

  # virt-manager
  environment.systemPackages = with pkgs; [ virt-manager ];
}
