{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    catppuccin,
    ...
  } @ inputs: {
    nixosConfigurations = {
      vm = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/vm/configuration.nix
          inputs.home-manager.nixosModules.default
          catppuccin.nixosModules.catppuccin

          {
            home-manager.users.kendell = {
              imports = [
                ./hosts/vm/home.nix
                catppuccin.homeManagerModules.catppuccin
              ];
            };
          }
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/laptop/configuration.nix
          inputs.home-manager.nixosModules.default
          catppuccin.nixosModules.catppuccin

          {
            home-manager.users.kendell = {
              imports = [
                ./hosts/laptop/home.nix
                catppuccin.homeManagerModules.catppuccin
                #./modules/home-manager/theme.nix
              ];
            };
          }
        ];
      };
    };
  };
}
