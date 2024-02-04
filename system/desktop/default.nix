{ enable }: { ... }: {
  imports = if enable then [
    # ./hyprland
    # ./gnome
    ./kde

    ./fonts.nix
    ./amd.nix
    ./audio.nix
  ] else [];
}
