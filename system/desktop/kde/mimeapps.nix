{ ... }: { hm = [ ({ ... }: {
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "sioyek.desktop";
    "x-scheme-handler/http" = "chromium-browser.desktop";
    "x-scheme-handler/https" = "chromium-browser.desktop";
    "x-scheme-handler/mailto" = "chromium-browser.desktop";
    "text/html" = "chromium-browser.desktop";
  };
}) ]; }
