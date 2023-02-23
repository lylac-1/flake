{
  pkgs,
  config,
  inputs,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      kamadorueda.alejandra
      jnoortheen.nix-ide
    ];
  };
}
