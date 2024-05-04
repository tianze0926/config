{ ... }: let
  # default = "firefox";
  default = "brave-browser";

  mimetypes = [
    "text/html"
    "text/xml"
    "application/xhtml+xml"
    "application/vnd.mozilla.xul+xml"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
  ];
in {
  xdg.mimeApps.defaultApplications = with builtins; listToAttrs (map (
    v: {
      name = v;
      value = "${default}.desktop";
    }
  ) mimetypes);
}
