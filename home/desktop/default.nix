{ pkgs, ... }: {
  imports = [
    ./hyprland

    ./terminal.nix
    ./mpv.nix
    ./pdf.nix
    ./wemeet
  ];

  home.packages = with pkgs; [
    xorg.xeyes
    gparted
    firefox ungoogled-chromium
    libreoffice
    jellyfin-media-player
    font-manager
    vscodium-fhs
    inkscape-with-extensions
    wireshark
    myRepo.owncloud-client
    zotero_7
    praat
    remmina
    audacity
    cloudflared
  ];

}
