{
  inputs,
  config,
  pkgs,
  hyprland,
  mcolours,
  lib,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = import ./hyprland_garden.nix {inherit mcolours lib;};
  };
}
