{ pkgs, lib, ... }: {
  environment.pathsToLink = [ "/share/fcitx5" ];

  environment.variables = {
    GTK_IM_MODULE = lib.mkForce "";
  };

}
