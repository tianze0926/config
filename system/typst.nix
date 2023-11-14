{ pkgs, lib, ... } : {
  environment.systemPackages = [
    pkgs.typst
    pkgs.myRepo.typst-svg-emoji
  ];
  hm = [({ ... }: {
    xdg.dataFile."typst".source = "${pkgs.myRepo.typst-svg-emoji}/share/typst";
  })];

  fonts.fontDir.enable = true;
  environment.variables = {
    TYPST_FONT_PATHS = "/run/current-system/sw/share/X11/fonts";
  };
}
