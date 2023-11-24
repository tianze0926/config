{ pkgs, lib, ... } : {
  environment.systemPackages = with pkgs; [
    typst
    myRepo.typst-svg-emoji
    entr
  ];
  hm = [({ ... }: {
    xdg.dataFile."typst".source = "${pkgs.myRepo.typst-svg-emoji}/share/typst";
  })];

}
