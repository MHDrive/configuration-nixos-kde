{ pkgs }:

pkgs.writeShellScriptBin "gpu-switch" ''
	#! /bin/sh
    case "$1" in
		default|offload)
			echo "Beralih ke mode default (hybrid offload)..."
			/run/current-system/bin/switch-to-configuration switch
          	;;
        sync)
			echo "Beralih ke mode hybrid sync..."
			/run/current-system/specialisation/hybrid-sync/bin/switch-to-configuration switch
			;;
        *)
          echo "Penggunaan: gpu-switch [default|offload|sync]"
          echo "  default, offload : Mode hybrid offload (default)"
          echo "  sync             : Mode hybrid sync (specialisation)"
          ;;
      esac
    ''
