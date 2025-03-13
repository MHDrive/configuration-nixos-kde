{ pkgs }:

pkgs.writeShellScriptBin "list-specialisations" ''
	#!/bin/sh
	echo "Specialisations yang tersedia:"
	for spec in /run/current-system/specialisation/*; do
	  if [ -d "$spec" ]; then
	    name=$(basename "$spec")
	    echo "- $name"
	  fi
	done

	current=$(readlink -f /run/booted-system)
	if [[ $current == *specialisation* ]]; then
	  active=$(echo $current | sed -n 's/.*specialisation\/\([^/]*\)\/.*/\1/p')
	  echo -e "\nSpecialisation aktif: $active"
	else
	  echo -e "\nTidak ada specialisation yang aktif (menggunakan konfigurasi default)"
	fi
''
