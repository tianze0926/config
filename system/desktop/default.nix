{ enable }: { ... }: {
  imports = if enable then [
    ./hyprland
    # ./gnome
    # ./kde

    ./fonts.nix
    ./fcitx5.nix
    ./amd.nix
    ./audio.nix
    ./webhook.nix
  ] else [];
}
