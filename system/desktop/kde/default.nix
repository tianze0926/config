{ pkgs, ... }: {
  imports = [
    ./fcitx5.nix
    ./cursor.nix
    ./plasma-manager
  ];

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";
  services.xserver.desktopManager.plasma5.enable = true;

  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    libsForQt5.yakuake
    wl-clipboard
  ];

}
