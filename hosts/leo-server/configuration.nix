# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ inputs, outputs, opt, config, pkgs, ... }:

let
  proxy.http = "http://127.0.0.1:2081";
  proxy.socks = "127.0.0.1:2080";
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./fhs.nix
      ./home-manager.nix
      ./printing.nix
    ];

  nixpkgs.overlays = [
    outputs.overlays.stable-packages
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${opt.user}" = import ../../home;
    extraSpecialArgs = { inherit inputs outputs opt; };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = opt.hostName;
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.dhcpcd.extraConfig = builtins.concatStringsSep "\n" [
    # OpenWrt is not flexible enough w.r.t. whitelisting firewall inbounds.
    # To only whitelist the inbounds of the server, the following approach is used:
    # - Add a static lease to set IPv6 suffix (e.g. `11`). DUID must be specified.
    # - In Firewall - Traffic Rules, add a rule with the following settings:
    #   - Source zone: wan
    #   - Destination zone: lan
    #   - Destination address: `::11/-64` for example (note the minus symbol)
    # - Disable autoconf in dhcpcd settings with `ipv6ra_noautoconf`, such that only
    #   the address from DHCPv6 would be selected for DDNS.
    "ipv6ra_noautoconf"
  ];
  services.cron = rec {
    interface = "enp1s0";
    # After power loss, it would be unable to acquire unicast address (public address)
    # but only unique local address (starts with fd) from OpenWrt.
    dhcpCheck = pkgs.writeShellScriptBin "dhcp-check" ''
      has_unique=false

      while read -r line; do
        [[ ! $line == fd* ]] && [[ ! $line == fe80* ]] && has_unique=true
      done <<<$(grep ${interface} /proc/net/if_inet6)

      if [ "$has_unique" = false ]; then
          rm /var/db/dhcpcd/${interface}.lease6
          systemctl restart dhcpcd.service
      fi
    '';
    config.enable = true;
    config.systemCronJobs = [ "*/2 * * * * root ${dhcpCheck}/bin/dhcp-check" ];
  }.config;
  boot.kernel.sysctl = {
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.rmem_max" = 2500000;
    "net.core.wmem_max" = 2500000;
  };


  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  networking.proxy.default = proxy.http;
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  nix.settings.substituters = [ "https://mirrors.cernet.edu.cn/nix-channels/store" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  fileSystems."/mnt/4t".device = "/dev/disk/by-uuid/e51fac7d-e566-d445-8654-f445a249b62e";

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
        ${docker}/bin/docker network create ${network} --ipv6 --subnet fd00:dead:beef::/48
    '';
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${opt.user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  security.sudo.extraConfig = ''
    ${opt.user} ALL=(ALL) NOPASSWD:ALL
  '';

  programs.fish.enable = true;
  programs.git.enable = true;
  programs.git.config = {
    http.proxy = proxy.http;
  };
  programs.ssh.extraConfig = ''
    Host github.com
      ProxyCommand ncat --proxy-type socks5 --proxy ${proxy.socks} --proxy-dns remote %h %p
      HostName github.com
  '';

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc gnumake nodejs_20 python312 nix-output-monitor
    zip unzipNLS
    file tree eza ripgrep fd fzf
    tmux neovim lazygit lf nnn
    neofetch htop btop iotop iftop lazydocker ncdu
    s-tui stress
    strace ltrace lsof sysstat lm_sensors ethtool pciutils usbutils
    bind wget nmap socat
  ];
  environment.variables = {
    SUDO_EDITOR = "nvim";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings.PasswordAuthentication = false;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

