{ ... }: {
  imports = [
    ./mpv.nix
  ];
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "sioyek.desktop";
  };
}
