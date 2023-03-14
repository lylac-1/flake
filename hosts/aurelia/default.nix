{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./users/lylac.nix
    ./users/root.nix
    ../../modules/services
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
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
  };
  system.stateVersion = "23.05";
}
