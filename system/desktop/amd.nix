{ pkgs, ... }: {
  hardware.graphics = let
    extra = [
      "libva-vdpau-driver"
      "libvdpau-va-gl"
    ];
  in {
    enable32Bit = true;
    extraPackages = map (x: pkgs.${x}) extra;
    extraPackages32 = map (x: pkgs.driversi686Linux.${x}) extra;
  };
  environment.systemPackages = with pkgs; [
    nvtopPackages.amd
  ];
}
