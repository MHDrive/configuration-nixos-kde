{ config, lib, pkgs, ... }:

{
  users.users.mh = {
    isNormalUser = true;
	description = "MH";
	# home = "/home/mh"
	# shell = pkgs.fish;
	extraGroups = [
	  "networkmanager"
	  "wheel"
	  # "phpdemo"
	];
	packages = with pkgs; [
	  # thunderbird
	];
  };
}
