{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    ./common.nix
    ./theme.nix
    ./hyprland
    ./tofi
    ./waybar
    ./alacritty.nix
    ./vscodium.nix
    ./chromium.nix
    ./mako.nix
  ];
}
