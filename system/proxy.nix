{ lib, config, ... }:
with lib;

let
  proxy.http = "http://127.0.0.1:1081";
  proxy.socks = "127.0.0.1:1080";

  cfg = config.custom.mainland;
in {
  options.custom.mainland.enable = mkEnableOption "Use proxy and mirrors";

  config = mkIf cfg.enable {
    networking.proxy.default = proxy.http;
    nix.settings.substituters = [ "https://mirrors.cernet.edu.cn/nix-channels/store" ];

    programs.git.config = {
      http.proxy = proxy.http;
    };
    programs.ssh.extraConfig = ''
      Host github.com
        ProxyCommand ncat --proxy-type socks5 --proxy ${proxy.socks} --proxy-dns remote %h %p
        HostName github.com
    '';
  };
}
