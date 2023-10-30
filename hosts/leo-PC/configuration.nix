# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ inputs, outputs, opt, config, pkgs, ... }:

let
  proxy.http = "http://127.0.0.1:1081";
  proxy.socks = "127.0.0.1:1080";
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.overlays = [
    outputs.overlays.stable-packages
    inputs.nur.overlay
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${opt.user}" = import ../../home;
    extraSpecialArgs = {
      inherit inputs outputs opt;
      desktop = true;
    };
  };


  # Limit the number of generations to keep
  boot.loader.systemd-boot.configurationLimit = 10;
  # boot.loader.grub.configurationLimit = 10;

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
 };

  # Optimize storage
  # You can also manually optimize the store via:
  #    nix-store --optimise
  # Refer to the following link for more details:
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = opt.hostName;
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager = {
    enable = true;
    extraConfig = ''
      [global-dns-domain-*]
      servers=119.29.29.29,2402:4e00::1
    '';
  };
  boot.kernel.sysctl = {
    "net.ipv4.tcp_congestion_control" = "bbr";
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

  programs.hyprland.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [
    vaapiVdpau
    libvdpau-va-gl
  ];
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.vaapiVdpau
    driversi686Linux.libvdpau-va-gl
  ];

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      libsForQt5.fcitx5-qt
      fcitx5-chinese-addons
      fcitx5-lua
      nur.repos.cryolitia.fcitx5-nord
    ];
  };

  services.ddccontrol.enable = true;

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
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts noto-fonts-cjk noto-fonts-emoji
    (nerdfonts.override { fonts = [ "Noto" ]; })
  ];
  fonts.fontconfig.localConf = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <alias>
        <family>sans-serif</family>
        <prefer>
          <family>Noto Sans CJK SC</family>
          <family>Noto Sans CJK TC</family>
          <family>Noto Sans CJK JP</family>
        </prefer>
      </alias>
      <alias>
        <family>monospace</family>
        <prefer>
          <family>Noto Sans Mono CJK SC</family>
          <family>Noto Sans Mono CJK TC</family>
          <family>Noto Sans Mono CJK JP</family>
        </prefer>
      </alias>
    </fontconfig>
  '';
  fonts.fontDir.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

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
  #programs.ssh.extraConfig = ''
  #  Host github.com
  #    ProxyCommand ncat --proxy-type socks5 --proxy ${proxy.socks} --proxy-dns remote %h %p
  #    HostName github.com
  #'';

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc gnumake nodejs_20 python312 nix-output-monitor
    zip unzipNLS
    file tree eza ripgrep fd fzf
    tmux neovim lazygit lf nnn
    neofetch btop iotop iftop s-tui lazydocker
    killall strace ltrace lsof sysstat lm_sensors ethtool pciutils usbutils
    bind wget nmap socat

    pulseaudio pavucontrol
    nvtop-amd
    ffmpeg
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
  #services.openssh = {
  #  enable = true;
  #  ports = [ 2222 ];
  #  settings.PasswordAuthentication = false;
  #};

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

