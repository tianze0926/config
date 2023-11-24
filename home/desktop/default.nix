{ pkgs, ... }: let
  cursor.package = pkgs.capitaine-cursors;
  cursor.name = "capitaine-cursors";
in {
  imports = [
    ./hyprland.nix
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
    iconTheme = { inherit (cursor) package name; };
  };

  programs.waybar = {
    enable = true;
    settings.mainBar = import ./waybar/config.nix;
    style = ./waybar/style.css;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 12.0;
    };
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
  ];

}
