{ pkgs, ... }: {
  home.packages = with pkgs; [
    libsForQt5.okular
  ];

  programs.sioyek.enable = true;
  programs.sioyek.config = {
    should_launch_new_window = "1";
    startup_commands = builtins.concatStringsSep ";" [
      "toggle_scrollbar"
    ];
  };
}
