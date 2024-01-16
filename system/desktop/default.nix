{ enable }: { ... }: {
  imports = if enable then [
    ./hyprland

    ./fonts.nix
    ./amd.nix
  ] else [];
}
