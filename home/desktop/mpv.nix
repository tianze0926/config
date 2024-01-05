{ config, pkgs, lib, osConfig, ... }: {
  programs.mpv = {
    enable = true;
    config = {
      player-operation-mode = "pseudo-gui";
      sub-font-size = "45";
      autofit-larger = "1920x1080";
    };
  };
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "float,class:^(mpv)$"
  ];

  # uri scheme
  xdg.mimeApps.defaultApplications."x-scheme-handler/mpv" = "mpv-uri.desktop";
  xdg.desktopEntries.mpv-uri = let
    script = pkgs.writeText "mpv-uri.sh" rec {
      mapper = v: rec {
        value = v.LD_LIBRARY_PATH or [];
        res = if builtins.isList value then value else [ value ];
      }.res;
      libpath = lib.unique (builtins.concatLists (builtins.map mapper [
        config.home.sessionVariables
        osConfig.environment.variables
        osConfig.environment.sessionVariables
        osConfig.environment.profileRelativeSessionVariables
      ]));
      res = ''
        export LD_LIBRARY_PATH=${builtins.concatStringsSep ":" libpath}
        ${config.programs.mpv.package}/bin/mpv ''${1#mpv://}
      '';
    }.res;
  in {
    name = "mpv for uri scheme";
    exec = "${pkgs.bash}/bin/bash ${script} %u";
  };
}
