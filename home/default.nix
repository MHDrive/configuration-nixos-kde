{ config, pkgs, lib, ...  }:
{
	# imports = lib.mh.autoImport.subDir ./.;
	imports = [
	  ./programs/default.nix
	  ./wm/default.nix
	  ./dotfiles/xdg-script/default.nix
	];
	home = {
		username = "mh";
		homeDirectory = "/home/mh";
		packages = with pkgs; [
			# htop
		];
		file = {
			# ".local/share/user-places.xbel" = {
			# 	source = ./configuration/user-places.xbel;
			# };
			# ".local/share/fastfetch/images" = {
			# 	source = ./configuration/fastfetch/images;
			# 	# recursive = true;
			# 	# executable = true;
			# };
		};
		activation.copyFastfetchImages = 
		let
		  to = "${config.home.homeDirectory}/.local/share/fastfetch/images";
		  from = ./dotfiles/local/share/fastfetch/images;
		in 
		lib.hm.dag.entryAfter [ "writeBoundary" ] ''
			[ -e "${to}" ] || mkdir -p "${to}"
			cp -rf "${from}/"* "${to}/"
		'';

		activation.copyConfigNiri = 
		let
		  to = "${config.xdg.configHome}/niri";
		  from = ./dotfiles/config/niri;
		in
		lib.hm.dag.entryBefore [ "writeBoundary" ] ''
		  [ -e "${to}" ] || mkdir -p "${to}"
		  cp -rf "${from}/"* "${to}/"
		'';

		# activation.copyConfigWaybar = 
		# let
		#   to = "${config.xdg.configHome}/waybar";
		#   from = ./dotfiles/config/waybar;
		# in
		# lib.hm.dag.entryBefore [ "writeBoundary" ] ''
		#   [ -e "${to}" ] || mkdir -p "${to}"
		#   cp -rf "${from}/"* "${to}/"
		# '';
		stateVersion = "24.11";
	};
}
