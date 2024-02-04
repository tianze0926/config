{ pkgs, ... }: {
  hm = [({ ... }: let
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
  in {
    home.file.".icons/${name}".source = "${package}/share/icons/${name}";
  })];
}
