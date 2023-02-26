{
  mcolours,
  lib,
}: ''
  exec-once=swaybg -o DP-1 -m fill -i ~/.bg1 -o HDMI-A-1 -i ~/.bg2
  exec-once=waybar -b mainBar

  monitor=DP-1,1920x1080@144,0x0,1
  monitor=HDMI-A-1,1920x1080@60,1920x0,1
  workspace=DP-1,1
  workspace=HDMI-A-1,6
  ${lib.concatMapStringsSep "\n" (n: "wsbind=${n},DP-1") ["1" "2" "3" "4" "5"]}
  ${lib.concatMapStringsSep "\n" (n: "wsbind=${n},HDMI-A-1") ["6" "7" "8" "9"]}
  ${lib.concatMapStringsSep "\n" (n: "bind=SUPER,${n},workspace,${n}") ["1" "2" "3" "4" "5" "6" "7" "8" "9"]}
  ${lib.concatMapStringsSep "\n" (n: "bind=SUPER:SHIFT,${n},movetoworkspacesilent,${n}") ["1" "2" "3" "4" "5" "6" "7" "8" "9"]}

  input {
    follow_mouse=2
  }
  general {
    gaps_in=5
    gaps_out=10
    border_size=3
    col.active_border=${"0xFF" + mcolours.primary.main}
    col.inactive_border=${"0xFF" + mcolours.primary.bg}
  }
  decoration {
    rounding=5
  	multisample_edges=true
  }
  animations {
    enabled=1
    animation=windows,1,2,default
    animation=border,1,2,default
    animation=fade,1,2,default
    animation=workspaces,1,1,default,slidevert
  }
  misc {
    disable_hyprland_logo=true
    disable_splash_rendering=true
    disable_autoreload=true
  }
  dwindle {
    pseudotile=false
    force_split=2
    preserve_split=true
  }

  bind=,`,pass,^(discord)$
  bind=SUPER,RETURN,exec,alacritty
  bind=SUPER:SHIFT,Q,killactive,
  bind=SUPER,M,exit,
  bind=SUPER,J,togglefloating,
  bind=SUPER,K,fullscreen,
  bind=SUPER,P,pin,
  bind=SUPER,[,pseudo,
  bind=SUPER:SHIFT,s,exec,grim -g "$(slurp -d)" - | wl-copy -t image/png
  bind=SUPER:,s,exec,grim -g "0,0 3840x1080" - | wl-copy -t image/png
  bind=SUPER,L,exec,swaylock -c ${mcolours.primary.bg} --inside-color ${mcolours.primary.bg} --ring-color ${mcolours.primary.main} --text-color ${mcolours.primary.main} --line-color ${mcolours.bright.magenta}
  bind=SUPER,d,exec,tofi-drun --drun-launch true --terminal alacritty
  bindm=SUPER,mouse:272,movewindow
  bindm=SUPER,mouse:273,resizewindow

  bind=SUPER,left,movefocus,l
  bind=SUPER,right,movefocus,r
  bind=SUPER,up,movefocus,u
  bind=SUPER,down,movefocus,d

''
