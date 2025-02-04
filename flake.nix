{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = {
    self,
    nixpkgs,
    catppuccin,
    nix-flatpak,
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
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/desktop/configuration.nix
          inputs.home-manager.nixosModules.default
          catppuccin.nixosModules.catppuccin
          {
            home-manager.users.kendell = {
              imports = [
                ./hosts/desktop/home.nix
                catppuccin.homeManagerModules.catppuccin
                ./modules/home-manager/spicetify.nix
                nix-flatpak.homeManagerModules.nix-flatpak
              ];
            };
          }
        ];
      };
    };
  };
}
