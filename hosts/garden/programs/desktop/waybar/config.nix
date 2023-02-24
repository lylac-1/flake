{
  pkgs,
  config,
  inputs,
  ...
}: {
  programs.waybar = {
    settings = {
      bar1 = {
        layer = "top";
        position = "bottom";
        height = 30;
        output = ["DP-1"];
        modules-left = ["wlr/workspaces"];
        modules-center = [];
        modules-right = ["pulseaudio#in" "pulseaudio#out" "clock"];
        "wlr/workspaces" = {
          all-outputs = false;
          active-only = false;
          sort-by-number = true;
          on-click = "activate";
        };
        "pulseaudio#out" = {
          on-click = "wpctl set-mute 50 toggle";
          format = " {volume}%";
          format-muted = "";
        };
        "pulseaudio#in" = {
          on-click = "wpctl set-mute 51 toggle";
          format = "{format_source}";
          format-muted = "{format_source}";
          format-source = "";
          format-source-muted = "";
        };
        "clock" = {
          format = " {:%H:%M}";
          format-alt = " {:%a %d %b}";
        };
      };
      bar2 = {
        layer = "top";
        position = "bottom";
        height = 24;
        output = ["HDMI-A-1"];
        modules-left = ["wlr/workspaces"];
        modules-center = [];
        modules-right = ["pulseaudio#in" "pulseaudio#out" "network#speed" "network" "tray" "clock"];
        "wlr/workspaces" = {
          all-outputs = false;
          active-only = false;
          sort-by-number = true;
          on-click = "activate";
        };
        "pulseaudio#out" = {
          on-click = "wpctl set-mute 50 toggle";
          format = " {volume}%";
          format-muted = "";
        };
        "pulseaudio#in" = {
          on-click = "wpctl set-mute 51 toggle";
          format = "{format_source}";
          format-muted = "{format_source}";
          format-source = "";
          format-source-muted = "";
        };
        "clock" = {
          format = " {:%H:%M}";
          format-alt = " {:%a %d %b}";
        };
        "network" = {
          format = " loading";
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = " {ifname}";
          format-disconnected = " disconnected";
        };
        "network#speed" = {
          format-ethernet = "{bandwidthDownBytes} : {bandwidthUpBytes}";
        };
        "tray" = {
          show-passive-items = true;
        };
      };
    };
  };
}
