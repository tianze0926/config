{ pkgs, ... }: {
  imports = [
    ./hyprland.nix
    ./dunst.nix
    ./mimeapps
    ./theme.nix
  ];

  programs.waybar = {
    enable = true;
    settings.mainBar = import ./waybar/config.nix;
    style = ./waybar/style.css;
  };

  home.packages = with pkgs; [
    xdg-utils xorg.xhost
    nautilus
    copyq
    wl-clipboard
    rofi-wayland grimblast
    networkmanagerapplet
    iw
    polkit_gnome
    ark
  ];

  wayland.windowManager.hyprland.settings = {
    bind = let
      pin = pkgs.writeShellScriptBin "pin" ''
        tmpfile=$(mktemp)
        ${pkgs.copyq}/bin/copyq read image/png > $tmpfile
        ${pkgs.imv}/bin/imv $tmpfile
        rm $tmpfile
      '';
    in [
      "$mainMod, F1, exec, grimblast copy area"
      "$mainMod, F3, exec, ${pin}/bin/pin"
    ];
    windowrulev2 = [
      "float,class:^(imv)$"
    ];
  };
}
