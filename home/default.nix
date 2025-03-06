{ config, pkgs, ...  }:
{

	home = {
		username = "mh";
		homeDirectory = "/home/mh";
		packages = with pkgs; [
			# htop
		];
		stateVersion = "24.11";
	};
	programs = {
		fastfetch = {
			enable = true;
		};
		bash = {
			enable = true;
		};
		starship = {
			enable = true;
			package = pkgs.starship;
			enableBashIntegration = true;
		};
		git = {
			enable = true;
			userName = "Muhammad Hamdi";
			userEmail = "hamdj360@gmail.com";		
		};
		home-manager.enable = true;
	};
}
