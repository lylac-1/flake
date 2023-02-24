{
  pkgs,
  config,
  inputs,
  ...
}: {
  users.users.root = {
    shell = pkgs.zsh;
    passwordFile = config.age.secrets.lylac-pass.path;
  };
  home-manager.users.root = {
    imports = [
      ./programs/zsh.nix
      (import ./programs/vim.nix {prompt = "'%~ # '";})
    ];
    home.stateVersion = "23.05";
  };
}
