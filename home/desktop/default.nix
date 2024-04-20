{ pkgs, ... }: {
  imports = [
    ./hyprland
    # ./gnome

    ./terminal.nix
    ./mpv.nix
    ./pdf.nix
    ./xwayland
    ./chromium.nix
  ];

  home.packages = with pkgs; [
    xorg.xeyes
    gparted
    firefox
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
    obs-studio
  ];

}
