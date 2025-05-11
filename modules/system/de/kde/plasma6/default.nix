{ config, pkgs, lib, ... }:

{
  config = lib.mkIf config.services.desktopManager.plasma6.enable {
	environment = {
  		systemPackages = with pkgs.kdePackages; [
			qtsvg
			filelight
		];
		plasma6.excludePackages = with pkgs.kdePackages; [
			# plasma-browser-integration
  			# konsole
			elisa

			# gunakan nix-store -qR /run/current-system | grep nama packages.
			# dolphin-plugins
			# ark
			# okular
			# gwenview
			# kate
			# spectacle
			#
			# plasma-*
			#
			# kio-*
		]; 
  	};
	programs = {
		kdeconnect.enable = lib.mkDefault true;
		partition-manager.enable = lib.mkDefault true;
	};
	xdg.portal = {
		enable = lib.mkDefault true;
	};
  };
}
