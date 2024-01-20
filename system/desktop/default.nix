{ enable }: { ... }: {
  imports = if enable then [
    # ./hyprland
    ./gnome

    ./fonts.nix
    ./amd.nix
    ./audio.nix
  ] else [];
}
