{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = inputs@{ self, home-manager, nixpkgs, ... }: {
    nixosConfigurations.nix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixpkgs.nixosModules.notDetected
        ./machines/nix.nix
      ];
    };

    homeConfigurations = {
      edwards = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/edwards";
        username = "edwards";
        stateVersion = "21.05";
        configuration = { config, pkgs, ... }:
          let
            overlay-unstable = final: prev: {
              unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
            };
          in
          {
            nixpkgs.overlays = [ overlay-unstable ];
            nixpkgs.config = {
              allowUnfree = true;
              allowBroken = true;
            };

            imports = [
              ./users/edwards
            ];
          };
      };
    };

    edwards = self.homeConfigurations.edwards.activationPackage;
    defaultPackage.x86_64-linux = self.edwards;
  };
}
