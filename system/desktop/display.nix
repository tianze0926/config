{ ... }: { imports = [
  ({ ... }: {
    programs.hyprland.enable = true;
    services.ddccontrol.enable = true;
  })
  ({ pkgs, ... }: let
    pkg = pkgs.swaylock;
    pam = "swaylock";
  in {
    environment.systemPackages = [ pkg ];
    security.pam.services."${pam}".text =
      builtins.readFile "${pkg}/etc/pam.d/${pam}";
    hm = [({ ... }: {
      home.file.".swaylock/config".text = ''
        color=000000
      '';
    })];
  })
  ({ pkgs, ... }: {
    hardware.opengl.driSupport32Bit = true;
    hardware.opengl.extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
    hardware.opengl.extraPackages32 = with pkgs; [
      driversi686Linux.vaapiVdpau
      driversi686Linux.libvdpau-va-gl
    ];
    environment.systemPackages = with pkgs; [
      nvtop-amd
    ];
  })
];}
