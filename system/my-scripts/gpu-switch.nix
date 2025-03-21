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
            # Gunakan parameter kedua jika ada, defaultnya "switch" jika tidak ada
            REBUILD_MODE="''${2:-switch}"
            echo "Beralih ke mode hybrid sync dengan rebuild... ($REBUILD_MODE)"
            "/nix/var/nix/profiles/system/specialisation/hybrid-sync/bin/switch-to-configuration" "$REBUILD_MODE"
            ;;
        sync-no-rebuild)
            echo "Beralih ke mode hybrid sync tanpa rebuild..."
            "$SPECIALISATION_PATH/hybrid-sync/activate"
            ;;
        *)
            echo "Penggunaan: gpu-switch [default|offload|sync-with-rebuild [mode]|sync-no-rebuild]"
            echo "  default, offload      : Mode hybrid offload (default)"
            echo "  sync-with-rebuild [mode]: Mode hybrid sync with rebuild (specialisation)"
            echo "    mode: check|switch|boot|test|dry-activate (default: switch)"
            echo "  sync-no-rebuild       : Mode Hybrid sync no rebuild (specialisation)"
            ;;
    esac
''
