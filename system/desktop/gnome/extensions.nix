{ pkgs, ... }: {
  environment.systemPackages = with pkgs.gnomeExtensions; [
    appindicator
    kimpanel
  ];
  services.udev.packages = with pkgs; [
    gnome.gnome-settings-daemon # https://nixos.wiki/wiki/GNOME#Systray_Icons
  ];

  hm = [({ ... }: {
    dconf.settings."org/gnome/shell".enabled-extensions = [
      "appindicatorsupport@rgcjonas.gmail.com"
      "kimpanel@kde.org"
    ];
  })];

}
