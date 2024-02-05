{ lib, pkgs, ... }: {
  options.custom.lf.preview = lib.mkOption { default = true; };

  config.hm = [
    ({ config, ... }: {
      programs.lf.enable = true;
      programs.lf.extraConfig = ''
        setlocal ${config.home.homeDirectory}/Downloads sortby time
        setlocal ${config.home.homeDirectory}/Downloads reverse
      '';
    })
    ({ lib, osConfig, ... }: lib.mkIf osConfig.custom.lf.preview {
      home.packages = with pkgs; [
        myRepo.ctpv
        exiftool # any
        chafa myRepo.tmux imagemagick # image
        poppler_utils # pdf
        highlight # text
        ffmpegthumbnailer # video
      ];
      xdg.configFile."ctpv/config".text = ''
        set chafasixel
      '';
      programs.lf.settings = {
        sixel = true;
        previewer = "ctpv";
        cleaner = "ctpvclear";
      };
    })
  ];
}
