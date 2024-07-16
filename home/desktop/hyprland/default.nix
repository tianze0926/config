{ pkgs, ... }: {
  imports = [
    ./hyprland.nix
    ./dunst.nix
    ./mimeapps
    ./theme.nix
  ];

  programs.waybar = {
    enable = true;
    settings.mainBar = import ./waybar/config.nix;
    style = ./waybar/style.css;
  };

  home.packages = with pkgs; [
    xdg-utils xorg.xhost
    gnome.nautilus
    copyq
    rofi-wayland grimblast
    networkmanagerapplet
    polkit_gnome
    ark
  ];

}
