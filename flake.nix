{
  description = "GenesisOS — Sovereign Modular Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.asgard-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # 1. Host Configuration (Hardware + Kernel)
        ./hosts/asgard-laptop

        # 2. System Modules (Core)
        ./modules/core

        # 3. Home Manager for user tiberiu
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.tiberiu = import ./users/tiberiu;
        }
      ];
    };
  };
}
