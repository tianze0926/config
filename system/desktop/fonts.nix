{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans noto-fonts-cjk-serif
    noto-fonts-emoji
    source-sans source-serif
    source-han-sans source-han-serif source-han-mono
    (nerdfonts.override { fonts = [ "CodeNewRoman" ]; })
  ];
  fonts.fontconfig.defaultFonts = {
    serif = [ "Noto Serif" "Noto Serif CJK SC" ];
    sansSerif = [ "Noto Sans" "Noto Sans CJK SC" ];
    monospace = [ "CodeNewRoman Nerd Font" "Noto Sans Mono CJK SC" ];
    emoji = [ "Noto Color Emoji" ];
    };
  fonts.fontDir.enable = true;

}
