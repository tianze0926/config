# https://blog.taoky.moe/2023-05-22/wemeet-screencast-in-wayland.html
{ pkgs, config, ... }: let
  # https://github.com/taoky/scripts/blob/f88a9a00eac1931a596dfdcb3d91b626279dc8b1/x11/wemeet/start.sh
  xwayland-wm = pkgs.writeShellScriptBin "xwayland-wm" ''
    ${pkgs.xwayland}/bin/Xwayland :114 -ac -retro +extension RANDR +extension RENDER \
      +extension GLX +extension XVideo +extension DOUBLE-BUFFER \
      +extension SECURITY +extension DAMAGE +extension X-Resource \
      -extension XINERAMA -xinerama -extension MIT-SHM +extension Composite \
      +extension COMPOSITE -extension XTEST -tst -dpms -s off -geometry 1920x1080 &
    sleep 1
    DISPLAY=:114 ${pkgs.openbox}/bin/openbox &
    sleep 1
    DISPLAY=:114 ${pkgs.xorg.xsetroot}/bin/xsetroot -solid "#000000"
  '';
in {
  home.packages = [
    xwayland-wm
    pkgs.myRepo.xdp-screen-cast
    pkgs.xclip
  ];
  xdg.configFile.openbox.source = ./openbox;


}
