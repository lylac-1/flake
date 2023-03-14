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
          sha256 = "sha256-lNf2oUybWEJFAudCuqG6Y83O1KIc9WUXz5hRyQrHng8=";
        };
        cargoHash = "sha256-lNf2oUybWEJFAudCuqG6Y83O1KIc9WUXz5hRyQrHng8=";
      };
  in
    with pkgs; [
      susbot
    ];
}
