{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  age.secrets.nextcloud-auth = {
    file = ../../../secrets/nextcloud-auth.age;
    owner = "nextcloud";
  };
  services = {
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud25;
      hostName = "next.lylac.dev";
      home = "/mnt/storage/nextcloud";
      autoUpdateApps.enable = true;
      config = {
        overwriteProtocol = "https";
        trustedProxies = ["https://next.lylac.dev"];
        adminuser = "admin";
        adminpassFile = config.age.secrets.nextcloud-auth.path;
        dbtype = "pgsql";
        dbhost = "/run/postgresql";
        dbname = "nextcloud";
      };
      nginx.recommendedHttpHeaders = true;
      https = true;
    };
    postgresql = {
      enable = true;
      ensureDatabases = [config.services.nextcloud.config.dbname];
      ensureUsers = [
        {
          name = config.services.nextcloud.config.dbuser;
          ensurePermissions."DATABASE ${config.services.nextcloud.config.dbname}" = "ALL PRIVILEGES";
        }
      ];
    };
  };
  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };
}
