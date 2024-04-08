{ pkgs, ... }: {
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
    nvtopPackages.amd
  ];
}
