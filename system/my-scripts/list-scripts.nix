{ pkgs }:

pkgs.writeShellScriptBin "list-script" ''
	#! /bin/bash
	echo "Daftar script shell kustom di sistem:"
	for path in $(echo $PATH | tr ':' ' '); do 
		if [[ $path == *"/nix/store"* ]]; then
			for file in $(find $path -type f -executable 2>/dev/null); do 
				if file "$file" | grep -q "shell script"; then
					echo "- $(basename $file): $file"
				fi
			done
		fi
	done
''
