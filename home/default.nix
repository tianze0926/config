{ inputs, outputs, opt, config, osConfig, pkgs, desktop ? false, ... }:

{
  imports = [
  ] ++ (if desktop then [
    ./desktop
  ] else []);

  nixpkgs.overlays = [
    outputs.overlays.stable-packages
    inputs.nur.overlay
  ];

  home.username = opt.user;
  home.homeDirectory = "/home/${opt.user}";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "tianze0926";
    userEmail = "i@tianze.me";
    extraConfig.http.proxy = osConfig.networking.proxy.default;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    typst
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
