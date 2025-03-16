{ pkgs }:

pkgs.writeShellScriptBin "gpu-switch" ''
	#! /bin/sh

	PATH_GENERAL="/nix/var/nix/profiles/system"
	SPECIALISATION_PATH="$PATH_GENERAL/specialisation"

    case "$1" in
		default|offload)
			echo "Beralih ke mode default (hybrid offload)..."
			"$PATH_GENERAL/activate"
          	;;
        sync-with-rebuild)
			echo "Beralih ke mode hybrid sync dengan rebuild..."
			"$SPECIALISATION_PATH/hybrid-sync/bin/switch-to-configuration switch"
			;;
		sync-no-rebuild)
			echo "Beralih ke mode hybrid sync tanpa rebuild..."
			"$SPECIALISATION_PATH/hybrid-sync/activate"
			;;
        *)
          echo "Penggunaan: gpu-switch [default|offload|sync]"
          echo "  default, offload : Mode hybrid offload (default)"
          echo "  sync-with-rebuild: Mode hybrid sync with rebuild(specialisation)"
		  echo "  sync-no-rebuild  : Mode Hybrid sync no rebuild (specialisation)"
          ;;
      esac
    ''
