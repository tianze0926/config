{ pkgs, config, ... }: let
  compose_up = pkgs.writeShellScript "compose_up" ''
    set -e
    log () {
      logger --id=$$ -t printer-docker-up "$@"
    }

    DOCKER=${config.virtualisation.docker.package}/bin/docker
    until $DOCKER info > /dev/null 2>&1; do
      log "Waiting for Docker engine..."
      sleep 1
    done
    log starting $1

    VOLUME=cups_config
    CONTAINER=cups
    $DOCKER volume create $VOLUME
    $DOCKER rm -f $CONTAINER
    OUTPUT="$( \
      $DOCKER run -d --name $CONTAINER \
      -p 192.168.1.11:631:631 \
      --device $1 \
      -v $VOLUME:/etc/cups 2>&1 \
      registry.cn-beijing.aliyuncs.com/tianze0926/cups \
      || true)"

    log finished "$OUTPUT"
    echo "$OUTPUT" >> /tmp/asd
  '';
in {
  services.udev.extraRules = ''
    ATTR{product}=="HP LaserJet Professional M1136 MFP", ATTR{serial}=="000000000QHC1P87PR1a", RUN+="${compose_up} '%E{DEVNAME}'"
  '';
}
