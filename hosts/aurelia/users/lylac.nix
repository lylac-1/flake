{
  nixpkgs,
  home-manager,
  pkgs,
  config,
  inputs,
  ...
}: {
  age = {
    identityPaths = ["/root/.ssh/agenix-private"];
    secrets.lylac-pass = {
      file = ../../../secrets/lylac-pass.age;
      owner = "lylac";
    };
  };
  users.extraUsers.lylac = {
    isNormalUser = true;
    home = "/home/lylac";
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDCt7XPuY8rskXj51Bg+lFQQg4HFylrzRH1DWeVpsDjPVVzNuZqoZXj4AY2F/Ru+PntimnfIJAQvfzJ6PExzVI/j9zVwJAehIhEy94zY6tsEZrgleOksXFgHeeslUzgV2HQglzQ9JZXPB3aFbtNeTISJUXPwuZB3nk/8CqSkJTg9hBbNxryzdn67kneJ6ISW+7xyTi0ccuBvpWhRClcQDBs2F3Fm9VEeafkprlwobqwTxINKUzlqprKuOVirvBOERxQqdQ/WrR5lndOFZoWY5g2qIUZJ4vRLZiZxp7lTbIE224Ade46TlGevZptqSszK1wSEsSc6Qu6HgHqqOT3GE0TUaEtv8qbYp5TGbkFqlja4SCQkrVJRbG1Pgt5KYhPgCu5FMkAcoMvI/pj0KRLwGLt0WUAUVZLcTVzoH4xlHknlO+y3a3TgxK8wq10fgQPaFShZQXoqRugfjyRT7aALJlR4y6OnTDHgRjiQx2BKlzN18Ga8HMTmyIEpscr4ASK7q8= lylac@garden"];
    passwordFile = config.age.secrets.lylac-pass.path;
  };
  home-manager.users.lylac = {config, ...}: {
    imports = [
      (import ../../../modules/programs/zsh.nix {})
      ../../../modules/programs/vim.nix
    ];
    home = {
      username = "lylac";
      homeDirectory = "/home/lylac";
      packages = with pkgs; [
        wget
        neofetch
        htop
        ranger
        git
      ];
      stateVersion = "23.05";
    };
  };
  system.stateVersion = "23.05";
}
