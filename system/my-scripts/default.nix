{ pkgs };

let
  imports = [
	./list-scripts.nix
	./list-specialisations.nix
	./gpu-switch.nix
  ];
in 
  builtins.concatMap (path: import path { inherit pkgs; }) imports
  
