{ pkgs, opt, ...}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
  };
  users.users."${opt.user}".extraGroups = [ "libvirtd" ];

  # virt-manager
  programs.dconf.enable = true; # virt-manager requires dconf to remember settings
  environment.systemPackages = with pkgs; [ virt-manager ];
}
