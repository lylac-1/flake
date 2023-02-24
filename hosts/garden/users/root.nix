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
      ./programs/vim.nix
    ];
    programs.zsh.initExtra = ''
      PROMPT='%~ # '
    '';
    home.stateVersion = "23.05";
  };
}
