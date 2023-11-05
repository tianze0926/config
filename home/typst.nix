{ pkgs, ... } : {
  home.packages = [ pkgs.typst ];
  home.sessionVariables = {
    TYPST_FONT_PATHS = "/run/current-system/sw/share/X11/fonts";
  };
}
