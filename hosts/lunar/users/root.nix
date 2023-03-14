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
      (import ../programs/zsh.nix {prompt = "'%~ # '";})
      ../programs/vim.nix
    ];
    home.stateVersion = "23.05";
  };
}
