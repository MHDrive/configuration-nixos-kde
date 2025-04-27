{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	# niri window manager
    niri.url = "github:sodiboo/niri";

	# Stylix theming (optional)
    stylix.url = "github:danth/stylix";

	# fmpkgs.url= "github:fmway/fmpkgs";
  };

  outputs = inputs@{ nixpkgs, niri, home-manager, stylix, ... }: let
    lib = nixpkgs.lib.extend (_: _: { inherit mh; });
	mh = import ./utility/mylib { inherit lib; };
  in {
  	lib = mh;
    nixosConfigurations = {
      mh-nixos = lib.nixosSystem {
      	system = "x86_64-linux";
	  	specialArgs = {
			inherit inputs lib;
	  	};

      	modules = [
        	./system
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
