{ opt, pkgs, ... }: {
  services.webhook = {
    enable = true;
    user = opt.user;
    group = "users";
    ip = "127.0.0.1";
    port = 9000;
    hooks = {
      mpv = {
        execute-command = "${pkgs.mpv}/bin/mpv";
        pass-arguments-to-command = [ { source = "payload"; name = "url"; } ];
        pass-environment-to-command = [
          { source = "string"; envname = "XDG_RUNTIME_DIR"; name = "/run/user/1000"; }
          { source = "string"; envname = "WAYLAND_DISPLAY"; name = "wayland-1"; }
        ];
      };
    };
  };
}
