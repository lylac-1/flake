{
  pkgs,
  config,
  inputs,
  mcolours,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 1;
        padding = {
          x = 12;
          y = 12;
        };
      };
      font = {
        size = 12;
        normal = {
          family = "JetBrains Mono";
          style = "Regular";
        };
      };
      cursor = {
        style = "Underline";
        unfocused_hollow = false;
      };
      colors = {
        primary = {
          background = "#" + mcolours.primary.bg;
          foreground = "#" + mcolours.primary.fg;
        };
        normal = {
          black = "#" + mcolours.normal.black;
          red = "#" + mcolours.normal.red;
          green = "#" + mcolours.normal.green;
          yellow = "#" + mcolours.normal.yellow;
          blue = "#" + mcolours.normal.blue;
          magenta = "#" + mcolours.normal.magenta;
          cyan = "#" + mcolours.normal.cyan;
          white = "#" + mcolours.normal.white;
          orange = "#" + mcolours.normal.orange;
        };
        bright = {
          black = "#" + mcolours.bright.black;
          red = "#" + mcolours.bright.red;
          green = "#" + mcolours.bright.green;
          yellow = "#" + mcolours.bright.yellow;
          blue = "#" + mcolours.bright.blue;
          magenta = "#" + mcolours.bright.magenta;
          cyan = "#" + mcolours.bright.cyan;
          white = "#" + mcolours.bright.white;
          orange = "#" + mcolours.bright.orange;
        };
      };
    };
  };
}
