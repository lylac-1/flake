{
  nixpkgs,
  pkgs,
  lib,
  config,
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
          rev = "rust";
          sha256 = "sha256-i/aRyHnc6S7PqibNMTXKo1HUCqHZmfYNW0oVZh2gf8E=";
        };
        cargoHash = "sha256-lNf2oUybWEJFAudCuqG6Y83O1KIc9WUXz5hRyQrHng8=";
      };
  in
    with pkgs; [
      susbot
    ];
  age.secrets.susbot-token = {
    file = ../../../secrets/susbot-token.age;
    owner = "susbot";
  };
  users.extraUsers.susbot = {
    isSystemUser = true;
    group = "nogroup";
  };
  systemd.services.susbot = {
    description = "susbot runner";
    after = "network-online.target";
    serviceConfig = {
      User = "susbot";
      Type = "simple";
      ExecStart = "SusBot ${config.age.secrets.susbot-token.path}";
    };
  };
}