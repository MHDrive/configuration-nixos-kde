{ config, lib, pkgs, ... }:

{
  let
    cfg = config.programs.myniri;
  in 
  {
    options.programs.myniri = {
	  enable = lib.mkEnableOption "Niri, a scrollable-tiling Wayland Compositor";
	  package = lib.mkPackageOption pkgs ""
	};
  };
}
