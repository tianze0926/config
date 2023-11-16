{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ lf ];
  hm = [({ ... }: {
    programs.fish.functions.lf = ''
      cd (command lf -print-last-dir $argv)
    '';
  })];
}
