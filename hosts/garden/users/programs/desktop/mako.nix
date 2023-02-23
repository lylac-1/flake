{
  pkgs,
  config,
  inputs,
  mcolours,
  ...
}: {
  programs.mako = {
    enable = true;
    anchor = "bottom-right";
    ignoreTimeout = true;
    maxIconSize = 32;
    output = "HDMI-A-1";
  };
}
