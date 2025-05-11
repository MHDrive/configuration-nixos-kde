{ config, lib, pkgs, ... }:

with lib;

let
  isNewerKernel = versionAtLeast config.boot.kernelPackages.kernel.version "5.10";
in 
{
  imports = [ ../24.05-compat.nix ];

  options.hardware.setupNvidia = {
  	isLaptop = mkEnableOption "cek chassing anda, apakah laptop atau bukan" 
	// {
		default = true;
	};
  };
  
  config = {
    services.xserver.videoDrivers = [ "nvidia" ];
	hardware = {
		graphics = {
			enable = mkDefault true;
			enable32Bit = mkDefault true;
			extraPackages = with pkgs; [
				nvidia-vaapi-driver
			];
		};
		nvidia = {
			package = mkDefault config.boot.kernelPackages.nvidiaPackages.stable;
			modesetting.enable = mkDefault true;
			open = mkIf (lib.versionAtLeast config.hardware.nvidia.package.version "555") (mkDefault true);
			nvidiaSettings = mkDefault true;
			powerManagement = {
				enable = mkDefault (config.hardware.setupNvidia.isLaptop);
				finegrained = mkDefault false;
			};
			forceFullCompositionPipeline = mkDefault (!config.hardware.setupNvidia.isLaptop);
			nvidiaPersistenced = mkDefault (config.hardware.nvidia.datacenter.enable);
		};
	};

	environment.systemPackages = with pkgs; mkMerge [
		[ pciutils glxinfo vulkan-tools ]
		(mkIf (config.hardware.nvidia.prime.offload.enable && config.hardware.nvidia.prime.offload.enable) [
			(pkgs.writeShellScriptBin "nvidia-offload" ''
				export __NV_PRIME_RENDER_OFFLOAD=1
				export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
				export __GLX_VENDOR_LIBRARY_NAME=nvidia
				export __VK_LAYER_NV_optimus=NVIDIA_only
				exec "$@"
			'')
		])
	];
  };
}
