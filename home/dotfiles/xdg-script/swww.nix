{ ... }:

{
  xdg.configFile."scripts/swww/launch.sh" = {
    text = ''
	#!/bin/bash

	# Path ke folder wallpaper kamu
	WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

	# Ekstensi gambar yang didukung
	EXTENSIONS="jpg jpeg png"

	# Durasi dan tipe transisi
	TRANSITION_TYPE="any"
	TRANSITION_DURATION=1

	# Jalankan swww init jika belum jalan
	if ! pgrep -x "swww-daemon" > /dev/null; then
	    echo "Starting swww..."
	    swww init
	    sleep 0.5
	fi

	# Ambil daftar wallpaper
	IMAGES=()
	for ext in $EXTENSIONS; do
	    for img in "$WALLPAPER_DIR"/*.$ext; do
	        [ -e "$img" ] && IMAGES+=("$img")
	    done
	done

	# Pastikan ada wallpaper yang ditemukan
	if [ ${#IMAGES[@]} -eq 0 ]; then
	    echo "No wallpapers found in $WALLPAPER_DIR"
	    exit 1
	fi

	# Pilih wallpaper secara acak
	SELECTED="${IMAGES[RANDOM % ${#IMAGES[@]}]}"

	# Ganti wallpaper dengan transisi
	echo "Setting wallpaper: $SELECTED"
	swww img "$SELECTED" --transition-type "$TRANSITION_TYPE" --transition-duration "$TRANSITION_DURATION"
    '';
    executable = true;
  };
}
