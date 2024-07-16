# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ inputs, outputs, opt, config, pkgs, ... }: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import ../../system {
        proxy.enable = true;
        desktop.enable = true;
        disk_optimize.bootloader = "systemd-boot";
      })
      inputs.auto-cpufreq.nixosModules.default
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = opt.hostName;
  networking.networkmanager = {
    enable = true;
    settings."global-dns-domain-*".servers = "119.29.29.29,2402:4e00::1";
  };
  # # https://github.com/NixOS/nixpkgs/issues/180175#issuecomment-1658731959
  # systemd.services.NetworkManager-wait-online = {
  #   serviceConfig = {
  #     ExecStart = [ "" "${pkgs.networkmanager}/bin/nm-online -q" ];
  #   };
  # };
  boot.kernel.sysctl = {
    "net.ipv4.tcp_congestion_control" = "bbr";
  };

  time.timeZone = "Asia/Shanghai";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
  ];

  networking.firewall.enable = false;

  programs.auto-cpufreq.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

