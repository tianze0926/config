{ pkgs, inputs, ... }: let
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
    iconTheme.package = pkgs.adwaita-icon-theme;
    iconTheme.name = "Adwaita";
    theme.package = pkgs.gnome-themes-extra;
    theme.name = "Adwaita";
  };
  qt.style.name = "adwaita";
  home.packages = [
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];
  home.sessionVariables = {
    HYPRCURSOR_THEME = "rose-pine-hyprcursor";
    HYPRCURSOR_SIZE = 24;
  };

}
