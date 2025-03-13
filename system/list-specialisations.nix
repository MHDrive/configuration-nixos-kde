{ pkgs }:

pkgs.writeShellScriptBin "list-specialisations" ''
	#! /bin/sh
	echo "Specialisations yang tersedia:"
	for spec in /run/current-system/specialisation/*; do
	  if [ -d "$spec" ]; then
	    name=$(basename "$spec")
	    echo "- $name"
	  fi
	done

	current=$(readlink -f "/run/booted-system")
	if echo "$current" | grep -q "specialisation"; then
	  active=$(echo "$current" | awk -F 'specialisation/' '{print $2}' | cut -d'/' -f1)
	  echo "\nSpecialisation aktif: $active"
	else
	  echo "\nTidak ada specialisation yang aktif (menggunakan konfigurasi default)"
	fi

''
