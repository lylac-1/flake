{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./users/lylac.nix
  ];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "NZ";
  i18n.defaultLocale = "en_NZ.UTF-8";

  age.identityPaths = ["/root/.ssh/agenix-private"];

  programs = {
    dconf.enable = true; # required for desktop/theme.nix
    steam.enable = true; # needs system install steps
  };
  security = {
    polkit.enable = true; # wayland desktop
    rtkit.enable = true; # pipewire
    pam.services.swaylock = {}; # swaylock on hyprland requirement.
  };
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    dbus.enable = true;
    sshd.enable = true; # required for agenix apparently?
  };
  # wayland
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal
    ];
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
  system.stateVersion = "23.05";
}
