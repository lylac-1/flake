{
  pkgs,
  config,
  inputs,
  ...
}: {
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = [pkgs.vimPlugins.vim-nix];
    extraConfig = ''
      set number
      set nocompatible
      set backspace=indent,eol,start
      set tabstop=4
      syntax on
    '';
  };
}
