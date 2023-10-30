{ pkgs, ... }: let
  cursor.package = pkgs.capitaine-cursors;
  cursor.name = "capitaine-cursors";
in {
  imports = [
    ./mpv.nix
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

  wayland.windowManager.hyprland = {
    enable = true;
    settings = import ./hyprland.nix;
  };

  programs.alacritty = {
    enable = true;
  };

  home.packages = with pkgs; [
    xdg-utils
    firefox ungoogled-chromium
    copyq
    libreoffice
    jellyfin-media-player
  ];

}
