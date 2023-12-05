{ lib, pkgs, inputs, ... }: {
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  wayland.windowManager.hyprland.settings = {
    # See https://wiki.hyprland.org/Configuring/Monitors/
    monitor = [
      "DP-1,3840x2160,0x0,1.5"
      "eDP-1,2560x1600,2560x640,2"
    ];

    # See https://wiki.hyprland.org/Configuring/Keywords/ for more

    # Execute your favorite apps at launch
    # exec-once = waybar & hyprpaper & firefox
    exec-once = "waybar & copyq & blueman-applet & fcitx5 & firefox"
      + " & ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";

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
        render_titles = false;
        gradients = false;
      };
    };

    misc = {
      disable_hyprland_logo = true;
    };

    # Example windowrule v1
    # windowrule = float, ^(kitty)$
    # Example windowrule v2
    windowrulev2 = [
      "float,class:^(com.github.hluk.copyq)$"
      "workspace 10,class:^(org.freedesktop.Xwayland)$"
    ];
    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


    # See https://wiki.hyprland.org/Configuring/Keywords/ for more
    "$mainMod" = "SUPER";

    # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
    bind = [
      "$mainMod, Q, exec, foot"
      "$mainMod, C, killactive,"
      "$mainMod SHIFT, M, exit,"
      "$mainMod, E, exec, io.elementary.files"
      "$mainMod, F, togglefloating,"
      "$mainMod, V, exec, copyq show"
      "$mainMod, R, exec, rofi -show run"
      "$mainMod, P, pseudo,"
      "$mainMod, J, togglesplit,"
      "$mainMod, W, togglegroup,"
      "$mainMod, TAB, changegroupactive,f"
      "$mainMod SHIFT, TAB, changegroupactive,b"
      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
    ] ++ (let
      dict-dir = {
        left = "l"; h = "l"; right = "r"; l = "r"; up = "u"; k = "u"; down = "d"; j = "d";
      };
      dict-num = {
        "1"="1";"2"="2";"3"="3";"4"="4";"5"="5";"6"="6";"7"="7";"8"="8";"9"="9";"0"="10";
      };
      binds = lib.attrsets.mapAttrsToList;
    in builtins.concatLists [
      (binds (k: v: "$mainMod, ${k}, movefocus, ${v}") dict-dir)
      (binds (k: v: "$mainMod SHIFT, ${k}, movewindoworgroup, ${v}") dict-dir)
      (binds (k: v: "$mainMod CTRL SHIFT, ${k}, movecurrentworkspacetomonitor, ${v}") dict-dir)
      (binds (k: v: "$mainMod, ${k}, workspace, ${v}") dict-num)
      (binds (k: v: "$mainMod SHIFT, ${k}, movetoworkspace, ${v}") dict-num)
    ]);

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };
}
