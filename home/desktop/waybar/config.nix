{
  layer = "top";
  position = "top";
  #height = 30;
  modules-left = [
    "hyprland/workspaces"
  ];
  modules-right = [
    "network"
    "pulseaudio"
    "backlight"
    "memory"
    "cpu"
    "battery"
    "tray"
    "clock#date"
    "clock#time"
  ];

  battery = {
    interval = 10;
    states.warning = 30;
    states.critical = 15;
    format = " {icon}   {capacity}%";
    format-discharging = "{icon}   {capacity}%";
    format-icons = [ "" "" "" "" "" ];
    tooltip = true;
  };

  "clock#time" = {
    interval = 1;
    format = "{:%H:%M:%S}";
    tooltip = false;
  };

  "clock#date" = {
    interval = 10;
    format = "   {:%e %b %Y}";
    tooltip-format = "{:%e %B %Y}";
  };

  cpu = {
    interval = 5;
    format = "  {usage}% ({load})";
    states.warning = 70;
    states.critical = 90;
  };

  memory = {
    interval = 5;
    format = "󰍛  {}%";
    states.warning = 70;
    states.critical = 90;
  };

  network = {
    interval = 5;
    format-wifi = "   {essid} {bandwidthDownBytes} {bandwidthUpBytes}";
    format-ethernet = "󰈀  {ifname} {bandwidthDownBytes} {bandwidthUpBytes}";
    format-disconnected = "⚠  Disconnected";
    tooltip-format = "{ifname}: {ipaddr}";
  };

  "hyprland/workspaces" = {
    format = "{name}";
    on-scroll-up = "hyprctl dispatch workspace e+1";
    on-scroll-down = "hyprctl dispatch workspace e-1";
  };

  pulseaudio = {
    # "scroll-step": 1;
    format = "{icon}  {volume}%";
    format-bluetooth = "{icon}  {volume}%";
    format-muted = "󰝟";
    format-icons = {
      headphone = "";
      hands-free = "";
      headset = "";
      phone = "";
      portable = "";
      car = "";
      default = ["" ""];
    };
    on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
    on-click-right = "pavucontrol";
  };

  tray = {
    # icon-size = 21;
    spacing = 5;
  };

  backlight = {
    device = "amdgpu_bl0";
    format = "󰌢  {percent}%";
  };
}
