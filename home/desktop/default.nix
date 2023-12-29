{ pkgs, config, ... }: let
  cursor.package = pkgs.capitaine-cursors;
  cursor.name = "capitaine-cursors";
in {
  imports = [
    ./hyprland.nix
    ./terminal.nix
    ./mpv.nix
    ./dunst.nix
    ./mimeapps
    ./pdf.nix
    ./wemeet
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
    xdg-utils xorg.xhost xorg.xeyes
    pantheon.elementary-files
    gparted
    firefox ungoogled-chromium
    copyq
    libreoffice
    jellyfin-media-player
    rofi-wayland grimblast
    font-manager
    networkmanagerapplet
    polkit_gnome
    vscodium-fhs
    inkscape-with-extensions
    myRepo.owncloud-client
  ];

}
