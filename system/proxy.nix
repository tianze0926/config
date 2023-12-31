{ enable }: { lib, ... }: let
  proxy.http = "http://127.0.0.1:1081";
  proxy.socks = "127.0.0.1:1080";
in lib.mkIf enable {
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
}
