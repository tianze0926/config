{ ... }: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.fish = {
    enable = true;
    shellInit = ''
      set -x ff (string split \n $fx)
    '';
  };
}
