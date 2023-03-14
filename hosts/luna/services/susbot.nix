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
      cargoHash = "sha256-CbIaOENKP4q5aVca6Cjaz32qIVfnvCNzA+CiKaA+D/w=";
      meta.mainprogram = "SusBot";
    };
in {
  environment.systemPackages = [
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
    after = ["network-online.target"];
    serviceConfig = {
      User = "susbot";
      Type = "simple";
      ExecStart = "${lib.getExe susbot} ${config.age.secrets.susbot-token.path}";
    };
  };
}
