{ lib, pkgs, ... }: {
  options.custom.lf.preview = lib.mkOption { default = true; };

  config.hm = [
    ({ ... }: {
      programs.lf.enable = true;
    })
    ({ lib, osConfig, ... }: lib.mkIf osConfig.custom.lf.preview {
      home.packages = with pkgs; [
        ctpv
        exiftool # any
        chafa myRepo.tmux imagemagick # image
        poppler_utils # pdf
        highlight # text
        ffmpegthumbnailer # video
      ];
      xdg.configFile."ctpv/config".text = ''
        set chafasixel
      '';
      programs.lf.extraConfig = ''
        set sixel true
        set previewer ctpv
        set cleaner ctpvclear
        &ctpv -s $id
        &ctpvquit $id
      '';
    })
  ];
}
