{
  pkgs,
  config,
  inputs,
  mcolours,
  ...
}: {
  programs.waybar = {
    style = ''
      * {
        min-height: 0;
        min-width: 0;
        border: none;
        margin: 0;
        border-radius: 0;
        font-family: "JetBrains Mono", "Font Awesome 6 Free Solid";
      }
      window#waybar {
        background: #${mcolours.primary.bg};
      }
      #workspaces button {
        margin: 5px;
        background: #${mcolours.normal.black};
        border-radius: 5px;
        color: #${mcolours.primary.main};
      }
      #workspaces button.active {
        background: #${mcolours.primary.main};
        color: #${mcolours.normal.black};
      }
      #tray,
      #pulseaudio,
      #network,
      #clock {
        background: #${mcolours.normal.black};
        color: #${mcolours.primary.main};
        margin: 5px;
        border-radius: 5px;
        padding-left: 5px;
        padding-right: 5px;
      }
    '';
  };
}
