{ config, lib, ... }:

{
  imports = [
	# ../../common/cpu/intel
	../../common/gpu/intel
	../../common/gpu/nvidia
	
  ];
#   ++ lib.optional (lib.versionOlder lib.version "24.12pre") [
# 	./video-acceleration.nix
#   ];
   hardware = {
   	intelgpu.enableHybridCodec = true;
	nvidia = {
		package = config.boot.kernelPackages.nvidiaPackages.production;
		prime = {
			intelBusId = "PCI:0:2:0";
			nvidiaBusId = "PCI:1:0:0";
			offload = {
				enable = true;
				enableOffloadCmd = true;
			};
		};
	};
   };
   specialisation = {
	hybrid-sync = {
		inheritParentConfig = true;
		configuration = {
			system.nixos.tags = [ "hybrid-sync" ];

			hardware.nvidia = {
				powerManagement.enable = lib.mkForce false;
				prime = {
					sync.enable = lib.mkForce true;
					offload = {
						enable = lib.mkForce false;
						enableOffloadCmd = lib.mkForce false;
					};
				};
			};
		};
	};
   };
}
