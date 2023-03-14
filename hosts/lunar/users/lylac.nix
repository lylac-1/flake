{
  nixpkgs,
  home-manager,
  pkgs,
  config,
  inputs,
  ...
}: {
  age.secrets.lylac-pass = {
    file = ../../../secrets/lylac-pass.age;
    owner = "lylac";
  };
  users.extraUsers.lylac = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
    passwordFile = config.age.secrets.lylac-pass.path;
  };
  home-manager.users.lylac = {config, ...}: {
    imports = [
      (import ../programs/zsh.nix {}) # default is fine
      ../programs/desktop
      ../programs/vim.nix
    ];
    home = {
      username = "lylac";
      homeDirectory = "/home/lylac";
      packages = with pkgs; [
        yafetch
        chromium
        element-desktop
        discord
        mpv
        imv
        mpd
        ncmpcpp
        krita
        jetbrains.idea-community
        jetbrains.clion
        wl-clipboard
        grim
        slurp
        swaylock
        swaybg
        swayidle
      ];
      stateVersion = "23.05";
    };
  };
}
