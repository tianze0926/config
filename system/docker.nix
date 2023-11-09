{ pkgs, config, ... }: {
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_24;
    logDriver = "local";
    daemon.settings = {
      ipv6 = true;
      fixed-cidr-v6 = "2001:db8:1::/64";
      experimental = true;
      ip6tables = true;
    };
  };
  systemd.services."docker-network" = let
    network = "apps";
    docker = "${config.virtualisation.docker.package}/bin/docker";
  in {
    serviceConfig.Type = "oneshot";
    wantedBy = [ "docker.service" ];
    script = ''
      ${docker} network inspect ${network} > /dev/null 2>&1 ||\
        ${docker} network create ${network} --ipv6 --subnet fd00:dead:beef::/48
    '';
  };

}
