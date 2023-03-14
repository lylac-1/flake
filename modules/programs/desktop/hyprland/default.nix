{
  system,
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
    extraConfig = import ./hyprland_${system}.nix {inherit mcolours lib;};
  };
}
