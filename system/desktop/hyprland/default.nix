{ ... }: {
  imports = [
    ./display.nix
    ./fcitx5.nix
  ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.auto-cpufreq.enable = true;
  programs.dconf.enable = true; # virt-manager requires dconf to remember settings
}
