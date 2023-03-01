{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  security.acme = {
    acceptTerms = true;
    defaults.email = "acme@lylac.dev";
  };
  services.nginx = {
    enable = true;
    commonHttpConfig = ''
      real_ip_header CF-Connecting-IP;
      add_header 'Referrer-Policy' 'origin-when-cross-origin';
      add_header X-Frame-Options DENY;
      add_header X-Content-Type-Options nosniff;
    '';
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    virtualHosts = let
      template = {
        forceSSL = true;
        enableACME = true;
      };
    in {
      "lylac.dev" =
        template
        // {
          serverAliases = ["lylac.dev"];
          root = "/mnt/storage/volumes/website";
        };
      "jelly.lylac.dev" =
        template
        // {
          locations."/" = {
            proxyPass = "http://127.0.0.1:8096/";
            proxyWebsockets = true;
            extraConfig = "proxy_pass_header Authorization;";
          };
        };
      "vault.lylac.dev" =
        template
        // {
          locations."/" = {
            proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
            extraConfig = "proxy_pass_header Authorization;";
          };
        };
      "tea.lylac.dev" =
        template
        // {
          locations."/" = {
            proxyPass = "http://127.0.0.1:3001";
          };
        };
      ${config.services.nextcloud.hostName} = template;
    };
  };
}