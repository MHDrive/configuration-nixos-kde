{ pkgs }:

let
   imports = [
  	./list-specialisations.nix
  	./gpu-switch.nix
	];

	result = builtins.concatMap (path:
	  let imported = import path { inherit pkgs; };
	  in if builtins.isList imported then imported else [ imported ]
	) imports;
in 
  result
