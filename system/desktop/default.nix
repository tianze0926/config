{ enable }: { ... }: {
  imports = if enable then [
    ./display.nix
    ./fonts.nix
    ./fcitx5.nix
    ./media.nix
  ] else [];
}
