{ lib, ... }: {
  programs.plasma = import ./recMap.nix lib.mkForce {
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      cursorTheme = "capitaine-cursors";
    };
    shortcuts = {
      "org.codeberg.dnkl.foot.desktop"."_launch" = "Ctrl+Alt+T";
      "org.kde.konsole.desktop"."_launch" = [ ];
      "yakuake"."toggle-window-state" = "F9";
    };
    configFile = {
      "dolphinrc"."General"."GlobalViewProps" = false;
      "kcminputrc"."Mouse"."cursorTheme" = "capitaine-cursors";
      "kdeglobals"."General"."BrowserApplication" = "chromium-browser.desktop";
      "kdeglobals"."General"."TerminalApplication" = "foot";
      "kdeglobals"."General"."TerminalService" = "org.codeberg.dnkl.foot.desktop";
      "kdeglobals"."General"."fixed" = "CodeNewRoman Nerd Font,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."font" = "Noto Sans,10,-1,5,50,0,0,0,0,0";
      "kglobalshortcutsrc"."org.codeberg.dnkl.foot.desktop"."_k_friendly_name" = "Foot";
      "kglobalshortcutsrc"."yakuake"."_k_friendly_name" = "Yakuake";
      "klaunchrc"."FeedbackStyle"."BusyCursor" = false;
      # "klipperrc"."General"."IgnoreImages" = false;
      "klipperrc"."General"."MaxClipItems" = 256;
      "kwinrc"."Plugins"."wobblywindowsEnabled" = true;
      "kwinrc"."TabBox"."LayoutName" = "thumbnail_grid";
      "kwinrc"."Wayland"."InputMethod[$e]" = "/run/current-system/sw/share/applications/org.fcitx.Fcitx5.desktop";
      "kwinrc"."Windows"."DelayFocusInterval" = 0;
      "kwinrc"."Windows"."FocusPolicy" = "FocusFollowsMouse";
    };
  };

}
