{
  description = "lylac Nixos setup";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = github:ryantm/agenix;
    alejandra.url = github:kamadorueda/alejandra/3.0.0;
    hyprland.url = github:hyprwm/Hyprland;
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    agenix,
    alejandra,
    ...
  } @ inputs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    nixosConfigurations = {
      garden = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          {
            environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
            nix.nixPath = ["nixpkgs=/etc/nix/inputs/nixpkgs"];
            nix.registry.nixpkgs.flake = nixpkgs;
          }
          ./hosts/garden
          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
        ];
      };
      luna = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/luna
          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
        ];
      };
    };
    homeConfigurations.lylac = home-manager.lib.homeManagerConfiguration {
      modules = [
        (args: {
          xdg.configFile."nix/inputs/nixpkgs".source = nixpkgs.outPath;
          home.sessionVariables.NIX_PATH = "nixpkgs=${args.config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
        })
        {
          nix.registry.nixpkgs.flake = nixpkgs;
        }
      ];
    };
  };
}
