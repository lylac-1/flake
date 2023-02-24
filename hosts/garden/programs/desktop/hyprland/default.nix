{
  inputs,
  config,
  pkgs,
  hyprland,
  mcolours,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = import ./hyprland_config.nix {inherit mcolours;};
  };
}
