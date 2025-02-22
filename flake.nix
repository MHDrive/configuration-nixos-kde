{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };
  in
  {

    nixosConfigurations = {
     default = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit system; };
      
      modules = [
        ./configuration.nix
      ];
     };
    };
  };
}
