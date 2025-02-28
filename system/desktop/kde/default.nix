{ pkgs, ... }: {
  imports = [
    # ./fcitx5.nix
    # ./cursor.nix
    # ./plasma-manager
    # ./mimeapps.nix
  ];

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    # libsForQt5.yakuake
    # wl-clipboard
  ];

}
