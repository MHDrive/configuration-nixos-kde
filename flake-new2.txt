{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: let
    lib = nixpkgs.lib.extend (_: _: { inherit mh; });
    mh = import ./utility/mylib { inherit lib; };
  in {
    lib = mh;
    nixosConfigurations = {
      "asus-x441uv" = lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs lib;
        };
        modules = [
          ./hosts/my-laptop/asus-x441uv.nix          
        ];
      };
    };
  };
}

