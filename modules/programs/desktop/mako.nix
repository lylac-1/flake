{
  pkgs,
  config,
  inputs,
  mcolours,
  ...
}: {
  services.mako = {
    enable = true;
    defaultTimeout = 5;
    anchor = "bottom-right";
    layer = "top";
    output = "HDMI-A-1";
    maxIconSize = 32;
    backgroundColor = "#" + mcolours.primary.bg;
    textColor = "#" + mcolours.primary.fg;
    borderColor = "#" + mcolours.primary.main;
    borderRadius = 5;
  };
}
