{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }: {
    packages."x86_64-linux" = {
      laptop = self.homeManagerConfigurations.laptop.activationPackage;
      desktop = self.homeManagerConfigurations.desktop.activationPackage;
    };
    homeManagerConfigurations = {
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
