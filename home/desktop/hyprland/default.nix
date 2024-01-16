{ pkgs, ... }: let
  cursor.package = pkgs.capitaine-cursors;
  cursor.name = "capitaine-cursors";
in {
  imports = [
    ./hyprland.nix
    ./dunst.nix
    ./mimeapps
  ];

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    inherit (cursor) package name;
    size = 24;
  };
  gtk = {
    enable = true;
    cursorTheme = { inherit (cursor) package name; };
    iconTheme.package = pkgs.gnome.adwaita-icon-theme;
    iconTheme.name = "Adwaita";
    theme.package = pkgs.gnome.gnome-themes-extra;
    theme.name = "Adwaita";
  };
  qt.style.package = pkgs.adwaita-qt6;
  qt.style.name = "Adwaita";

  programs.waybar = {
    enable = true;
    settings.mainBar = import ./waybar/config.nix;
    style = ./waybar/style.css;
  };

  home.packages = with pkgs; [
    xdg-utils xorg.xhost
    pantheon.elementary-files
    copyq
    rofi-wayland grimblast
    networkmanagerapplet
    polkit_gnome
    ark
  ];

}
