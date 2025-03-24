{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	fmpkgs.url= "github:fmway/fmpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
  {
    nixosConfigurations = {
     default = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
	  specialArgs = { inherit inputs; };
      
      modules = [

		{ nixpkgs.overlays = [inputs.fmpkgs.overlays.default]; }

		{ inherit (inputs.fmpkgs) nixpkgs; }
        ./system/configuration.nix
        
        home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  
	  home-manager.users.mh = import ./home;
	}
      ];
     };
    };
  };
}
