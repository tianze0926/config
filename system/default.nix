{
  proxy,
  desktop,
  disk_optimize,
}: { pkgs, ... }: {
  imports = [
    ./user.nix
    (import ./disk_optimize.nix disk_optimize)
    (import ./proxy.nix proxy)
    ./overlays.nix
    ./docker.nix
    (import ./desktop desktop)
    (import ./home-manager.nix desktop)
    ./typst.nix
    ./lf.nix
  ];

  programs.fish.enable = true;
  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    gcc gnumake nodejs_20 python312
    nix-output-monitor nix-tree
    atool zip unzipNLS p7zip unar
    file tree eza ripgrep fd fzf
    tmux neovim lazygit nnn
    neofetch btop iotop iftop s-tui lazydocker
    strace ltrace lsof sysstat lm_sensors ethtool pciutils usbutils
    ncdu
    bind wget nmap socat
    ffmpeg
    expect
  ];
  environment.variables = {
    SUDO_EDITOR = "nvim";
  };
}
