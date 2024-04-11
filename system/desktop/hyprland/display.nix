{ ... }: { imports = [
  ({ inputs, pkgs, ... }: {
    programs.hyprland.enable = true;
    programs.hyprland.package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    services.ddccontrol.enable = true;
  })
  ({ pkgs, ... }: {
    environment.systemPackages = [ (pkgs.writeShellScriptBin "pin" ''
      tmpfile=$(mktemp)
      ${pkgs.copyq}/bin/copyq read image/png > $tmpfile
      ${pkgs.imv}/bin/imv $tmpfile
      rm $tmpfile
    '') ];
    hm = [({ ... }: {
      wayland.windowManager.hyprland.settings.windowrulev2 = [
        "float,class:^(imv)$"
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
