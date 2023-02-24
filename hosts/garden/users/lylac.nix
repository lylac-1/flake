{
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

  home-manager.users.lylac = {
    imports = [
      ../programs/desktop
      (import ../programs/zsh.nix {}) # default is fine
      ../programs/vim.nix
    ];
    home = {
      username = "lylac";
      homeDirectory = "/home/lylac";
      packages = with pkgs; [
        chromium
        element-desktop
        discord
        mpv
        imv
        mpd
        ncmpcpp
        prismlauncher-qt5 # gt6 isnt themed
        osu-lazer-bin
        krita

        # wayland desktop
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
