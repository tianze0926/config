{ lib, config, ... }:
with lib;
let
  cfg = config.custom.diskOptimize;
in {
  options.custom.diskOptimize.bootloader = mkOption {
    type = types.enum [ "systemd-boot" "grub" ];
  };

  # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/other-useful-tips#reducing-disk-usage
  config = {
    # Limit the number of generations to keep
    boot.loader."${cfg.bootloader}".configurationLimit = 10;

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
  };

}
