{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }:
    {
      packages."x86_64-linux" = {
        laptop = self.homeManagerConfigurations.laptop.activationPackage;
        desktop = self.homeManagerConfigurations.desktop.activationPackage;
      };
      homeConfigurations = {
        desktop = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          configuration.imports = [ ./home.nix ];
          username = "felix";
          homeDirectory = "/home/felix";
        };
        laptop = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          configuration.imports = [ ./home-laptop.nix ];
          username = "felix";
          homeDirectory = "/home/felix";
        };
      };
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./nix/system/laptop.nix ];
        };
      };
    };
}
