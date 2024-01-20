{ pkgs, ... }: {
  imports = [
    ./extensions.nix
    ./fcitx5.nix
  ];

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  hm = [({ ... }: {
    dconf.settings = {
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
        edge-tiling = true;
        experimental-features = [
          "scale-monitor-framebuffer" # fractional scaling
        ];
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        speed = 0.4;
        tap-to-click = true;
      };
      "org/gnome/desktop/wm/preferences" = {
        focus-mode = "mouse";
      };
    };
  })];

  environment.variables = {
    QT_QPA_PLATFORM = "wayland";
  };
  environment.systemPackages = with pkgs; [
    gnome.dconf-editor
    flameshot
  ];

}
