{ pkgs, ... }: {
  hm = [({ ... }: let
    cursor.package = pkgs.capitaine-cursors;
    cursor.name = "capitaine-cursors";
  in {
    home.pointerCursor = {
      gtk.enable = true;
      # x11.enable = true;
      inherit (cursor) package name;
      size = 24;
    };
  })];
}
