{ pkgs, ... }: {
  fonts.enableDefaultPackages = false;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans noto-fonts-cjk-serif
    noto-fonts-emoji
    source-sans source-serif
    source-han-sans source-han-serif source-han-mono
    nerd-fonts.code-new-roman
    liberation_ttf # replace Times New Roman, Arial
  ];
  fonts.fontconfig.defaultFonts = {
    serif = [ "Noto Serif" "Noto Serif CJK SC" ];
    sansSerif = [ "Noto Sans" "Noto Sans CJK SC" ];
    monospace = [ "CodeNewRoman Nerd Font" "Noto Sans Mono CJK SC" ];
    emoji = [ "Noto Color Emoji" ];
  };
  fonts.fontconfig.localConf = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <alias>
        <family>Microsoft YaHei</family>
        <prefer>
          <family>Noto Sans CJK SC</family>
        </prefer>
      </alias>
      <alias>
        <family>Arial</family>
        <prefer>
          <family>Liberation Sans</family>
        </prefer>
      </alias>
    </fontconfig>
  '';

}
