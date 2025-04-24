{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	# fmpkgs.url= "github:fmway/fmpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: let
    lib = nixpkgs.lib.extend (_: _: { inherit mh; });
	mh = import ./utility/mylib { inherit lib; };
  in {
  	lib = mh;
    nixosConfigurations = {
      default = lib.nixosSystem {
      	system = "x86_64-linux";
	  	specialArgs = {
			inherit lib;
	  	};

      	modules = [
        	./system/configuration.nix
        	home-manager.nixosModules.home-manager
			{
	  			home-manager.useGlobalPkgs = true;
	  			home-manager.useUserPackages = true;
	  			home-manager.users.mh = import ./home;
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
