{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  virtualisation = {
    docker.enable = true;
    oci-containers = {
      backend = "docker";
      containers = {
        e6e = {
          image = "itzg/minecraft-server:java8";
          autoStart = true;
          ports = ["25565:25565"];
          environment = {
            EULA = "true";
            TYPE = "CURSEFORGE";
            CF_SERVER_MOD = "Enigmatica6ExpertServer-1.7.1.zip";
            MEMORY = "10G";
            TZ = "NZ";
            USE_AIKAR_FLAGS = "true";
          };
          volumes = ["/home/lylac/e6e/:/data"];
        };
      };
    };
  };
}
