{ lib, config, ... }: {
  # make mpv the default application for every mimetype it supports
  xdg.mimeApps.defaultApplications = builtins.listToAttrs (
    builtins.map (t: { name = t; value = "mpv.desktop"; }) rec {
      version = "0.36.0";
      testVersion = lib.trivial.warnIfNot (
        (builtins.parseDrvName config.programs.mpv.package.name).version == version
      ) "mpv mimetypes is out of date";
      desktop_file = testVersion builtins.fetchTree {
        type = "file";
        url = "https://raw.githubusercontent.com/mpv-player/mpv/v${version}/etc/mpv.desktop";
        narHash = "sha256-c+KneKaaUqVz8fdVsDYN7HO/4BTkEC5kvtsxtwHceuA=";
      };
      desktop_str = builtins.readFile desktop_file;
      mimetype_match = builtins.match ".*MimeType=([^\n]*);\n.*" desktop_str;
      mimetype_0 = builtins.elemAt mimetype_match 0;
      mimetype_split = lib.strings.splitString ";" mimetype_0;
    }.mimetype_split
  );
}
