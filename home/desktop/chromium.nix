{ pkgs, osConfig, lib, ... }: let
  browsers = {
    chromium = pkgs.ungoogled-chromium;
    brave = pkgs.brave;
  };
  flags = let
    imeFlag = if osConfig.services.xserver.desktopManager.gnome.enable
      then "--gtk-version=4"
      else "--enable-wayland-ime";
  in "--enable-features=UseOzonePlatform --ozone-platform=wayland ${imeFlag}";
  pkgWrapper = bin: pkg: pkgs.writeShellScriptBin bin ''
    ${pkg}/bin/${bin} ${flags} "$@"
  '';
  desktopWrapper = bin: pkg: {
    name = ".local/share/applications/${bin}-browser.desktop";
    value.source = pkgs.runCommand "${bin}-browser.desktop" {} ''
      cp ${pkg}/share/applications/${bin}-browser.desktop $out
      sed -i 's/%U/${flags} %U/g' $out
    '';
  };
in with lib.attrsets; {
  home.packages = mapAttrsToList pkgWrapper browsers;
  home.file = mapAttrs' desktopWrapper browsers;
}
