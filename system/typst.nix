{ pkgs, lib, ... } : {
  environment.systemPackages = [
    pkgs.typst
    pkgs.myRepo.typst-svg-emoji
  ];
  hm = [({ ... }: {
    xdg.dataFile."typst".source = "${pkgs.myRepo.typst-svg-emoji}/share/typst";
  })];

}
