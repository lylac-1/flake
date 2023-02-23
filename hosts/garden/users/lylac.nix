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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
    users.lylac = {
      imports = [
        ./programs/desktop
        ./programs/zsh.nix
        ./programs/vim.nix
      ];
      home = {
        username = "lylac";
        homeDirectory = "/home/lylac";
        packages = with pkgs; [
          chromium # should get around to applying ungoogled
          element-desktop # seems to ocasionally segfault on startup :shrug:
          discord
          mpv
          mpd
          ncmpcpp
          prismlauncher-qt5 # uses qt5 to be compatable with gtk theme
          osu-lazer-bin # needs version bump
          krita

          # wayland desktop
          wl-clipboard
          grim
          slurp
          swaylock
          swaybg
          swayidle
          imv
        ];
        stateVersion = "23.05";
      };
    };
  };
}
