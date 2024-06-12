{ pkgs, ... }: let
  cursor.package = pkgs.rose-pine-cursor;
  cursor.name = "BreezeX-RosePine-Linux";
in {
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

}
