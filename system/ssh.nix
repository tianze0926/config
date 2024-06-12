{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.autossh ];
  environment.variables.AUTOSSH_PORT = "0";
  programs.ssh.extraConfig = ''
    Host *
      ServerAliveInterval 3
  '';
}
