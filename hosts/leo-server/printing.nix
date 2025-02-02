# RATIONALE:
# - some old printers requires close-source drivers, thus needing docker
# - printer's device path may change after replugging (e.g. from /dev/bus/usb/001/002 to /dev/bus/usb/001/003), resulting in docker's `--device` not working
# - udev can create a fixed symlink of the device, but CUPS cannot recognize it
# - as a last resort, this method runs a script when udev detects a newly plugged device, which recreates the container with the correct device path

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
