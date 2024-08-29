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
  hm = [({ ... }: {
    # https://wiki.gentoo.org/wiki/AMDGPU#Configuration
    # https://www.kernel.org/doc/html/latest/gpu/amdgpu/thermal.html#pp-dpm
    programs.fish.functions.pp = ''
      switch $argv[1]
        case perf
          sudo auto-cpufreq --force performance
          echo manual | sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level
          echo 2 | sudo tee /sys/class/drm/card1/device/pp_dpm_sclk
          echo 3 | sudo tee /sys/class/drm/card1/device/pp_dpm_mclk
        case auto ""
          sudo auto-cpufreq --force reset
          echo auto | sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level
      end
    '';
  })];
}
