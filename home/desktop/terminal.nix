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
  };
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local config = {}
      config.font = wezterm.font_with_fallback {
        'CodeNewRoman Nerd Font',
        'Noto Sans CJK SC',
      }
      config.font_size = 11.0
      config.color_scheme = 'Classic Dark (base16)'
      config.window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
      }
      return config
    '';
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
