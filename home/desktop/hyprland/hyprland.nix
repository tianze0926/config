{ lib, pkgs, inputs, ... }: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    # See https://wiki.hyprland.org/Configuring/Monitors/
    monitor = let
      monitors = [
        {name = "DP-1"; w = 3840; h = 2160; scale = 1.5;}
        {name = "eDP-1"; w = 2560; h = 1600; scale = 2;}
      ];
      append = ",bitdepth,10"; # https://github.com/hyprwm/xdg-desktop-portal-hyprland/issues/172
    in let
      # monitors are placed from left to right, bottom-aligned
      max_h_m = lib.lists.fold (a: b: if a.h > b.h then a else b) {h = 0;} monitors;
      scale = m: key: builtins.ceil ((m."${key}" + 0.0) / m.scale);
      result = lib.lists.foldl (l: m: l ++ [(
        m // rec {
          x = if (builtins.length l) != 0 then (lib.lists.last l).xEnd else 0;
          y = scale max_h_m "h" - scale m "h";
          xEnd = x + scale m "w";
        }
      )]) [] monitors;
      t = toString;
    in map (m: "${m.name},${t m.w}x${t m.h},${t m.x}x${t m.y},${t m.scale}" + append) result;

    # See https://wiki.hyprland.org/Configuring/Keywords/ for more

    # Execute your favorite apps at launch
    # exec-once = waybar & hyprpaper & firefox
    exec-once = [
      "waybar"
      "sleep 1; copyq"
      "blueman-applet"
      "fcitx5"
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
    ];

    # Source a file (multi-file configs)
    # source = ~/.config/hypr/myColors.conf

    device = {
      name = "msft0001:00-04f3:3138-touchpad";
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
    decoration = {
      drop_shadow = false;
      blur.enabled = false;
    };

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
      "float,class:^(pavucontrol)$"
      "float,class:^(com.github.hluk.copyq)$"
      "float,class:^(org.gnome.Nautilus)$"
      "workspace 10,class:^(org.freedesktop.Xwayland)$"
    ];
    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


    # See https://wiki.hyprland.org/Configuring/Keywords/ for more
    "$mainMod" = "SUPER";

    # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
    bind = [
      "$mainMod, C, killactive,"
      "$mainMod SHIFT, M, exit,"
      "$mainMod, E, exec, nautilus"
      "$mainMod, F, togglefloating,"
      "$mainMod SHIFT, F, exec, hyprctl dispatch fullscreenstate -1 2; hyprctl setprop active syncfullscreen on"
      "$mainMod, V, exec, copyq show"
      "$mainMod, R, exec, rofi -show run"
      "$mainMod, L, exec, swaylock"
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
