{ config, lib, pkgs, inputs, ... }:

# let
#   mh = import ./../../utility/mylib { inherit lib; };
# in 
{
  imports = [
	# Import modul yang dibutuhkan
	
	# Import home-manager
	inputs.home-manager.nixosModules.default 
	{
	  home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.mh = import ./../../home;
      home-manager.extraSpecialArgs = { inherit inputs; };
      inputs.nixpkgs.overlays = [
        (self: super: {
          lib = super.lib.extend (_: _: { inherit mh; });
        })
      ];
	}
  ];

  networking.hostName = "asus-x441uv";
  time.timeZone = "Asia/Makassar";
  i18n.defaultLocale = "en_US.UTF-8";
  nixpkgs.config.allowUnfree = true;
}
