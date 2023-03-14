{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  age.secrets.deluge-auth = {
    file = ../../secrets/deluge-auth.age;
    owner = "deluge";
  };
  services = {
    deluge = {
      enable = true;
      openFirewall = true;
      package = pkgs.deluge-2_x;
      web = {
        enable = true;
        openFirewall = true;
      };
      declarative = true;
      authFile = config.age.secrets.deluge-auth.path;
      config = {
        download_location = "/mnt/storage/downloads/";
        allow_remote = true;
      };
    };
  };
}
