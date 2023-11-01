{ config, pkgs, ... }: {
  programs.mpv = {
    enable = true;
    config = {
      profile = "pseudo-gui";
    };
  };

  # uri scheme
  xdg.mimeApps.defaultApplications."x-scheme-handler/mpv" = "mpv-uri.desktop";
  xdg.desktopEntries.mpv-uri = {
    name = "mpv for uri scheme";
    exec = "${pkgs.bash}/bin/bash ${config.home.homeDirectory}/.config/mpv/mpv-uri.sh %u";
  };
  home.file.".config/mpv/mpv-uri.sh".text = ''
    ${config.programs.mpv.package}/bin/mpv ''${1#mpv://}
  '';
}
