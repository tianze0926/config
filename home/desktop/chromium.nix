{ pkgs, osConfig, ... }: let
  pkg = pkgs.ungoogled-chromium;
in {
  home.packages = [ pkg ];
  home.file.".local/share/applications/chromium-browser.desktop".source = let
    imeFlag = if osConfig.services.xserver.desktopManager.gnome.enable
      then "--gtk-version=4"
      else "--enable-wayland-ime";
    flags = "--enable-features=UseOzonePlatform --ozone-platform=wayland ${imeFlag}";
  in pkgs.runCommand "chromium-wayland-ime-desktop" {} ''
    cp ${pkg}/share/applications/chromium-browser.desktop $out
    sed -i 's/Exec=chromium/Exec=chromium ${flags}/g' $out
  '';
}
