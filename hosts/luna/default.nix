{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./services
    ./containers.nix
  ];
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "NZ";
  i18n.defaultLocale = "en_NZ.UTF-8";

  # user env setup.
  age = {
    identityPaths = ["/root/.ssh/agenix-private"];
    secrets.lylac-pass = {
      file = ../../secrets/lylac-pass.age;
      owner = "lylac";
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

  system.stateVersion = "23.05";
}
