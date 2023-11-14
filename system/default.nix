{ pkgs, ... }: {
  imports = [
    ./user.nix
    ./disk_optimize.nix
    ./proxy.nix
    ./overlays.nix
    ./docker.nix
    ./desktop
    ./home-manager.nix
    ./typst.nix
  ];

  programs.fish.enable = true;
  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    gcc gnumake nodejs_20 python312 nix-output-monitor
    atool zip unzipNLS p7zip unar
    file tree eza ripgrep fd fzf
    tmux neovim lazygit lf nnn
    neofetch btop iotop iftop s-tui lazydocker
    strace ltrace lsof sysstat lm_sensors ethtool pciutils usbutils
    bind wget nmap socat
    ffmpeg
  ];
  environment.variables = {
    SUDO_EDITOR = "nvim";
  };
}
