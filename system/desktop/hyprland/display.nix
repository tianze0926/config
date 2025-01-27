{ ... }: { imports = [
  ({ inputs, pkgs, ... }: {
    programs.hyprland.enable = true;
    programs.hyprland.package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    programs.hyprland.portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    xdg.portal.extraPortals = with pkgs; [
      # To enforce light theme instead of dark theme:
      # dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
      xdg-desktop-portal-gtk
    ];
    services.ddccontrol.enable = true;
    environment.systemPackages = with pkgs; [
      brightnessctl
    ];
    hm = [({ ... }: {
      wayland.windowManager.hyprland.settings.binde = [
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];
    })];
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
];}
