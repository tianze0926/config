{ ... }: {
  imports = [
    ./display.nix
    ./fcitx5.nix
  ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
