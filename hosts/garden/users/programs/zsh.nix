prompt: {
  pkgs,
  config,
  inputs,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    history = {
      save = 1000;
      size = 1000;
      path = "$HOME/.cache/zsh_history";
    };
    initExtra = ''
      PROMPT=${prompt}
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      # ctrl backwards / delete
      bindkey '^H' backward-kill-word
      bindkey '5~' kill-word
      # disable weird underline
      (( ''${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
      ZSH_HIGHLIGHT_STYLES[path]=none
      ZSH_HIGHLIGHT_STYLES[path_prefix]=none
    '';
    profileExtra = ''
      if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
        Hyprland
      fi
    '';
    shellAliases = {
      ls = "ls --color";
      luna = "ssh luna -p 40221 -i ~/.ssh/luna-private";
      lunacp = "scp -p 40221 -i ~/.ssh/luna-private";
      build-switch = "nixos-rebuild switch --flake .#garden --use-remote-sudo";
      build-dry = "nixos-rebuild dry-build --flake .#garden --use-remote-sudo";
      fetch = "neofetch";
    };
  };
}
