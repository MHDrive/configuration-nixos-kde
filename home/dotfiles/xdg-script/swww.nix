{
  xdg.configFile."scripts/swww/launch.sh" = {
    text = ''
      #!/run/current-system/sw/bin/bash

      WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
      EXTENSIONS="jpg jpeg png"
      TRANSITION_TYPE="any"
      TRANSITION_DURATION=1
      pkill -x swww-daemon
      if ! pgrep -x "swww-daemon" > /dev/null; then
        echo "Starting swww..."
        swww-daemon > /dev/null 2>&1 &
        sleep 0.5
      fi

      IMAGES=()
      for ext in $EXTENSIONS; do
        for img in "$WALLPAPER_DIR"/*.$ext; do
          [ -e "$img" ] && IMAGES+=("$img")
        done
      done

      if [ ''${#IMAGES[@]} -eq 0 ]; then
        echo "No wallpapers found in $WALLPAPER_DIR"
        exit 1
      fi

      INDEX=$(( RANDOM % ''${#IMAGES[@]} ))
      SELECTED="''${IMAGES[$INDEX]}"

      echo "Setting wallpaper: $SELECTED"
      swww img "$SELECTED" --transition-type "$TRANSITION_TYPE" --transition-duration "$TRANSITION_DURATION"
    '';
    executable = true;
  };
}

