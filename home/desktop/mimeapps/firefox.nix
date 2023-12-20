{ ... }: {
  xdg.mimeApps.defaultApplications = {
    "text/xml" = "firefox.desktop";
    "application/xhtml+xml" = "firefox.desktop";
    "application/vnd.mozilla.xul+xml" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
  };
}
