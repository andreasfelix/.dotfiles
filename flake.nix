{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }: {
    homeManagerConfigurations = {
      desktop = home-manager.lib.homeManagerConfigurations {
        system = "x86_64-linux";
        configuration.imports = [ ./home.nix ];
      };
      laptop = home-manager.lib.homeManagerConfigurations {
        system = "x86_64-linux";
        configuration.imports = [ ./home-laptop.nix ];
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
