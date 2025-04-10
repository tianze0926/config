{ pkgs, ... }:

let
  pingScript = ''
    IP=$(${pkgs.iproute2}/bin/ip route | grep default | ${pkgs.gawk}/bin/awk '{print $3}')
    TIMEOUT="10"
    RETRIES=10
    ping_ip() {
        ${pkgs.iputils}/bin/ping -c 1 -W $TIMEOUT $IP > /dev/null 2>&1
    }
    for (( i=1; i<=$RETRIES; i++ ))
    do
        if ping_ip; then
            echo "$(date) - ping success"
            exit 0
        fi
    done
    # if all attempts failed
    echo "Ping to $IP failed after $RETRIES attempts, shutting down the system."
    ${pkgs.systemd}/bin/systemctl poweroff
  '';
in

{
  systemd.services.ups_shutdown = {
    description = "Watcher that poweroff the system when UPS is up based on ping";
    after = [ "network.target" ];
    script = pingScript;
    serviceConfig = {
      Restart = "always";
      RestartSec = 60;
    };
    wantedBy = [ "multi-user.target" ];
  };
}

