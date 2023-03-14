{
  nixpkgs,
  pkgs,
  lib,
  config,
  ...
}: let
  susbot = with pkgs;
    rustPlatform.buildRustPackage rec {
      name = "SusBot";
      src = fetchFromGitea {
        domain = "tea.lylac.dev";
        owner = "Nixinova";
        repo = "SusBot";
        rev = "rust";
        sha256 = "sha256-uYtMy/rfMJPkBFDTEoKNtuogvdPlL/0Mnr//yZp5d0Y=";
      };
      cargoHash = "sha256-lNf2oUybWEJFAudCuqG6Y83O1KIc9WUXz5hRyQrHng8=";
      meta = {
        lib.mainprogram = "SusBot";
      };
    };
in {
  environment.systemPackages = [
    susbot
  ];
  age.secrets.susbot-token = {
    file = ../../../secrets/susbot-token.age;
    owner = "SusBot";
  };
  users.extraUsers.SusBot = {
    isSystemUser = true;
    group = "nogroup";
  };
  systemd.services.susbot = {
    description = "SusBot runner";
    after = ["network-online.target"];
    serviceConfig = {
      User = "SusBot";
      Type = "simple";
      ExecStart = "${lib.getExe SusBot} ${config.age.secrets.susbot-token.path}";
    };
  };
}
