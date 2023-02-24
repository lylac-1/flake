{mcolours}: ''
  exec-once=swaybg -i /home/lylac/.bg -m fill
  exec-once=waybar -b mainBar
  exec-once=openrgb -p main

  monitor=DP-1,1920x1080@144,0x0,1
  monitor=HDMI-A-1,1920x1080@60,1920x0,1

  workspace=DP-1,1
  workspace=HDMI-A-1,6
  wsbind=1,DP-1
  wsbind=2,DP-1
  wsbind=3,DP-1
  wsbind=4,DP-1
  wsbind=5,DP-1
  wsbind=6,HDMI-A-1
  wsbind=7,HDMI-A-1
  wsbind=8,HDMI-A-1
  wsbind=9,HDMI-A-1
  wsbind=10,HDMI-A-1

  input {
    follow_mouse=2
  }

  general {
    gaps_in=5
    gaps_out=10
    border_size=3
    # hyprland puts opcaity for some reason
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

  bind=SUPER,1,workspace,1
  bind=SUPER,2,workspace,2
  bind=SUPER,3,workspace,3
  bind=SUPER,4,workspace,4
  bind=SUPER,5,workspace,5
  bind=SUPER,6,workspace,6
  bind=SUPER,7,workspace,7
  bind=SUPER,8,workspace,8
  bind=SUPER,9,workspace,9
  bind=SUPER,0,workspace,10

  bind=SUPER:SHIFT,1,movetoworkspacesilent,1
  bind=SUPER:SHIFT,2,movetoworkspacesilent,2
  bind=SUPER:SHIFT,3,movetoworkspacesilent,3
  bind=SUPER:SHIFT,4,movetoworkspacesilent,4
  bind=SUPER:SHIFT,5,movetoworkspacesilent,5
  bind=SUPER:SHIFT,6,movetoworkspacesilent,6
  bind=SUPER:SHIFT,7,movetoworkspacesilent,7
  bind=SUPER:SHIFT,8,movetoworkspacesilent,8
  bind=SUPER:SHIFT,9,movetoworkspacesilent,9
  bind=SUPER:SHIFT,0,movetoworkspacesilent,10
''
