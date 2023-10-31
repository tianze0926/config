{
  # See https://wiki.hyprland.org/Configuring/Monitors/
  monitor = [
    "DP-1,3840x2160,0x0,1.5"
    "eDP-1,2560x1600,2560x640,2"
    #"DP-1,3840x2160,0x0,2"
    #"eDP-1,2560x1600,1920x280,2"
  ];
  workspace = [
    "1, monitor:DP-1"
    "2, monitor:eDP-1"
  ];
  
  
  # See https://wiki.hyprland.org/Configuring/Keywords/ for more
  
  # Execute your favorite apps at launch
  # exec-once = waybar & hyprpaper & firefox
  exec-once = "waybar & copyq & blueman-applet & fcitx5 & firefox";
  
  # Source a file (multi-file configs)
  # source = ~/.config/hypr/myColors.conf
  
  env = "XCURSOR_SIZE,24";
  
  "device:msft0001:00-04f3:3138-touchpad" = {
    sensitivity = 0.8;
    natural_scroll = true;
  };
  
  general = {
    gaps_in = 0;
    gaps_out = 0;
    border_size = 1;
    "col.active_border" = "rgb(285577)";
  };
  
  animations.enabled = false;
  
  dwindle = {
    pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
  };
  
  gestures = {
    workspace_swipe = true;
  };

  group = {
    groupbar = {
      font_size = 10;
      gradients = false;
    };
  };
  
  misc = {
    disable_hyprland_logo = true;
  };
  
  # Example windowrule v1
  # windowrule = float, ^(kitty)$
  # Example windowrule v2
  # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
  # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
  
  
  # See https://wiki.hyprland.org/Configuring/Keywords/ for more
  "$mainMod" = "SUPER";
  
  # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
  bind = [
    "$mainMod, Q, exec, alacritty"
    "$mainMod, C, killactive,"
    "$mainMod SHIFT, M, exit,"
    "$mainMod, E, exec, dolphin"
    "$mainMod, F, togglefloating," 
    "$mainMod, V, exec, copyq show" 
    "$mainMod, R, exec, rofi -show run"
    "$mainMod, P, pseudo,"
    "$mainMod, J, togglesplit,"
    "$mainMod, W, togglegroup,"
    "$mainMod, TAB, changegroupactive,f"
    "$mainMod SHIFT, TAB, changegroupactive,b"
    # Move focus with mainMod + arrow keys
    "$mainMod, left, movefocus, l"
    "$mainMod, h, movefocus, l"
    "$mainMod, right, movefocus, r"
    "$mainMod, l, movefocus, r"
    "$mainMod, up, movefocus, u"
    "$mainMod, k, movefocus, u"
    "$mainMod, down, movefocus, d"
    "$mainMod, j, movefocus, d"
    # Switch workspaces with mainMod + [0-9]
    "$mainMod, 1, workspace, 1"
    "$mainMod, 2, workspace, 2"
    "$mainMod, 3, workspace, 3"
    "$mainMod, 4, workspace, 4"
    "$mainMod, 5, workspace, 5"
    "$mainMod, 6, workspace, 6"
    "$mainMod, 7, workspace, 7"
    "$mainMod, 8, workspace, 8"
    "$mainMod, 9, workspace, 9"
    "$mainMod, 0, workspace, 10"
    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    "$mainMod SHIFT, 1, movetoworkspace, 1"
    "$mainMod SHIFT, 2, movetoworkspace, 2"
    "$mainMod SHIFT, 3, movetoworkspace, 3"
    "$mainMod SHIFT, 4, movetoworkspace, 4"
    "$mainMod SHIFT, 5, movetoworkspace, 5"
    "$mainMod SHIFT, 6, movetoworkspace, 6"
    "$mainMod SHIFT, 7, movetoworkspace, 7"
    "$mainMod SHIFT, 8, movetoworkspace, 8"
    "$mainMod SHIFT, 9, movetoworkspace, 9"
    "$mainMod SHIFT, 0, movetoworkspace, 10"
    # Move window to direction
    "$mainMod SHIFT, left, movewindoworgroup, l"
    "$mainMod SHIFT, h, movewindoworgroup, l"
    "$mainMod SHIFT, right, movewindoworgroup, r"
    "$mainMod SHIFT, l, movewindoworgroup, r"
    "$mainMod SHIFT, up, movewindoworgroup, u"
    "$mainMod SHIFT, k, movewindoworgroup, u"
    "$mainMod SHIFT, down, movewindoworgroup, d"
    "$mainMod SHIFT, j, movewindoworgroup, d"
    # Scroll through existing workspaces with mainMod + scroll
    "$mainMod, mouse_down, workspace, e+1"
    "$mainMod, mouse_up, workspace, e-1"
  ];
  
  # Move/resize windows with mainMod + LMB/RMB and dragging
  bindm = [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];
}
