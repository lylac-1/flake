{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
  ];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "NZ";
  i18n.defaultLocale = "en_NZ.UTF-8";

  age.identityPaths = ["/root/.ssh/agenix-private"];

  age.secrets = {
    lylac-pass = {
      file = ../../secrets/lylac-pass.age;
      owner = "lylac";
    };
    deluge-auth = {
      file = ../../secrets/deluge-auth.age;
      owner = "deluge";
    };
  };

  users.extraUsers.lylac = {
    isNormalUser = true;
    home = "/home/lylac";
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = import ./lylac-pub.nix;
    passwordFile = config.age.secrets.lylac-pass.path;
  };

  environment = {
    variables = {EDITOR = "vim";};
    systemPackages = with pkgs; [
      vim
      wget
      neofetch
      htop
      ranger
      git
    ];
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "acme@lylac.dev";
  };
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
        SIGNUPS_ALLOWED = true;
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
      };
    };
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    gitea = {
      enable = true;
      domain = "tea.lylac.dev";
      rootUrl = "https://tea.lylac.dev/";
      httpPort = 3001;
    };
    postgresql = {
    };
    deluge = {
      enable = true;
      package = pkgs.deluge-2_x;
      openFirewall = true;
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

    nginx = {
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
      virtualHosts = {
        "lylac.dev" = {
          forceSSL = true;
          enableACME = true;
          serverAliases = ["lylac.dev"];
          root = "/mnt/storage/volumes/website";
        };
        "jelly.lylac.dev" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:8096/";
            proxyWebsockets = true;
            extraConfig = "proxy_pass_header Authorization;";
          };
        };
        "vault.lylac.dev" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
            extraConfig = "proxy_pass_header Authorization;";
          };
        };
        "tea.lylac.dev" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:3001";
          };
        };
      };
    };
  };
  system.stateVersion = "unstable";
}
