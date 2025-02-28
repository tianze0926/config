{ pkgs, ... }: {
  imports = [
    # ./hyprland
    # ./gnome

    ./terminal.nix
    ./mpv.nix
    ./pdf.nix
    ./xwayland
    ./chromium.nix
    ./email.nix
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
    zotero_7
    praat
    remmina
    audacity
    cloudflared
    obs-studio
    qrscan
    qutebrowser
  ];

}
