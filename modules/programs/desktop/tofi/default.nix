{
  mcolours,
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.tofi];
  home.file.".config/tofi/config".text = import ./config.nix {inherit mcolours;};
}
