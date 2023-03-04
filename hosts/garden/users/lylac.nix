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

      file = {
        "Documents".source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/Documents";
        "Music".source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/Music";
        "Pictures".source = config.lib.file.mkOutOfStoreSymlink "/mnt/storage/Pictures";
      };

      packages = with pkgs; [
        chromium
        element-desktop
        discord
        mpv
        imv
        mpd
        ncmpcpp
        prismlauncher-qt5
        osu-lazer-bin
        krita

        # wayland
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
