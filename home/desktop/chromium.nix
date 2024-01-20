{ pkgs, ... }: let
  pkg = pkgs.ungoogled-chromium;
in {
  home.packages = [ pkg ];
  home.file.".local/share/applications/chromium-browser.desktop".source = let
    flags = "--enable-features=UseOzonePlatform --ozone-platform=wayland --gtk-version=4";
  in pkgs.runCommand "chromium-wayland-ime-desktop" {} ''
    cp ${pkg}/share/applications/chromium-browser.desktop $out
    sed -i 's/Exec=chromium/Exec=chromium ${flags}/g' $out
  '';
}
