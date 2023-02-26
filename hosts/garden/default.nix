{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
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

  imports = [
    ./hardware.nix
    ./users/lylac.nix
    ./users/root.nix
  ];

  time.timeZone = "NZ";
  i18n.defaultLocale = "en_NZ.UTF-8";

  age.identityPaths = ["/root/.ssh/agenix-private"];

  programs = {
    dconf.enable = true; # theme.nix
    steam.enable = true;
  };
  security = {
    polkit.enable = true; # wayland
    rtkit.enable = true; # pipewire
    pam.services.swaylock = {}; # hyprland
  };
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    dbus.enable = true;
    sshd.enable = true;
    hardware.openrgb = {
      enable = true;
      motherboard = "amd";
    };
  };

  xdg.portal = {
    enable = true; # wayland
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal
    ];
  };
  users.extraUsers.openrgb = {
    isSystemUser = true;
    group = "nogroup";
    createHome = true;
    home = "/var/lib/openrgb";
  };
  systemd.services.openrgbprofile = {
    description = "apply openrgb profile main";
    wantedBy = ["multi-user.target"];
    requires = ["openrgb.service"];
    serviceConfig = {
      Type = "notify";
      User = "openrgb";
      ExecStart = "${lib.getExe pkgs.openrgb} -p main";
    };
  };

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome
    jetbrains-mono
  ];
  environment = {
    systemPackages = with pkgs; [
      inputs.agenix.packages."${system}".default # see nixos.wiki/wiki/Agenix
      inputs.alejandra.defaultPackage.x86_64-linux # nix fmt
      wget
      htop
      git
      ranger
      xdg-utils # wayland
    ];
    shells = with pkgs; [zsh]; # see nixos.wiki/wiki/Command_Shell
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
  };
  system.stateVersion = "23.05";
}
