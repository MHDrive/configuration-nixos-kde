{ config, pkgs, lib, ...  }:
{
	imports = [
		./programs
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
		  from = ./configuration/fastfetch/images;
		in 
		lib.hm.dag.entryAfter [ "writeBoundary" ] ''
			[ -e "${to}" ] || mkdir -p "${to}"
			cp -rf "${from}/"* "${to}/"
		'';
		stateVersion = "24.11";
	};
}
