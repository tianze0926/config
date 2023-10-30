{ ... }: {
  services.dunst.enable = true;
  services.dunst.settings = {
    global = {
      follow = "mouse";
    };
  };
}
