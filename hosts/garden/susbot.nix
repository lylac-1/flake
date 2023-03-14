{
  nixpkgs,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = let
    susbot = with pkgs;
      rustPlatform.buildRustPackage rec {
        name = "susbot";
        src = fetchFromGitea {
          domain = "tea.lylac.dev";
          owner = "Nixinova";
          repo = "SusBot";
          rev = "a";
        };
        cargoHash = "sha256-i/aRyHnc6S7PqibNMTXKo1HUCqHZmfYNW0oVZh2gf8E=";
      };
  in
    with pkgs; [
      susbot
    ];
}
