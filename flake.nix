{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: let
	mh = import ./utility/mylib { inherit (nixpkgs) lib; };
    lib = nixpkgs.lib.extend (_: _: { inherit mh; });
    # mh = import ./utility/mylib { inherit (nixpkgs) lib; };
  in {
    lib = mh;
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs lib;
        };

        modules = [
          ./modules
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mh = import ./home;
            home-manager.extraSpecialArgs = { inherit inputs; };
            nixpkgs.overlays = [
              (self: super: {
                lib = super.lib.extend (_: _: { inherit mh; });
              })
            ];
          }          
        ];
      };
    };
  };
}

