{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./nextcloud.nix
    ./nginx.nix
    ./deluge.nix
    ./jellyfin.nix
    ./containers.nix
    ./susbot.nix
  ];
  services = {
    openssh = {
      enable = true;
      ports = [40221];
      settings = {
        permitRootLogin = "no";
        passwordAuthentication = false;
      };
      openFirewall = true;
    };
    vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://vault.lylac.dev";
        SIGNUPS_ALLOWED = false;
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
      };
    };
    gitea = {
      enable = true;
      domain = "tea.lylac.dev";
      rootUrl = "https://tea.aurelia.cafe";
      httpPort = 3001;
      settings = {
        ui = {
          DEFAULT_THEME = "arc-green";
        };
        service = {
          DISABLE_REGISTRATION = true;
        };
        server = {
          LANDING_PAGE = "/explore/repos";
        };
      };
    };
  };
}
