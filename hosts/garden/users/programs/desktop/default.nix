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
    ./neofetch
    ./tofi
    ./waybar
    ./alacritty.nix
    ./vscodium.nix
  ];
}
