{ config, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 11.0;
    };
  };
  programs.foot = {
    enable = true;
    settings.main = {
      font = "monospace:size=11";
      include = "${config.programs.foot.package.themes}/share/foot/themes/hacktober";
    };
    settings.tweak.font-monospace-warn = false;
  };
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };

  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod, Q, exec, foot"
      "$mainMod, T, exec, alacritty"
    ];
    windowrulev2 = [
      "float,class:^(Alacritty)$"
    ];
  };
}
