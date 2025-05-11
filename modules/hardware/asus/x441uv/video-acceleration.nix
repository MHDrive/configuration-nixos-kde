{ config, lib, pkgs, ... }:

let
  cfg = config.hardware.intelgpu;
in 
{
  config = {
	hardware.graphics = {
		enable = true;
		extraPackages = with pkgs; [
			libvdpau-va-gl
		] ++ lib.optionals (!cfg.enableHybridCodec && (cfg.vaapiDriver == "intel-vaapi-driver" || cfg.vaapiDriver == null)) [
			intel-vaapi-driver
		] ++ lib.optionals (!cfg.enableHybridCodec && (cfg.vaapiDriver == "intel-media-driver" || cfg.vaapiDriver == null)) [
			intel-media-driver
		];
		extraPackages32 = with pkgs.driversi686Linux; lib.optionals (!cfg.enableHybridCodec && (cfg.vaapiDriver == "intel-vaapi-driver" || cfg.vaapiDriver == null)) [
			intel-vaapi-driver
		];
	};
  	environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
  };
}
