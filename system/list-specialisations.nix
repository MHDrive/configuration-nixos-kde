{ pkgs }:

pkgs.writeShellScriptBin "list-specialisations" ''
#!/bin/bash

# Mendapatkan path sistem
system_path=$(readlink -f /run/current-system)
echo "Path sistem: $system_path"

# Cek apakah menggunakan specialisation langsung
if echo "$system_path" | grep -q "/specialisation/"; then
    specialisation=$(echo "$system_path" | sed -n 's/.*\/specialisation\/\([^\/]*\)\/.*/\1/p')
    echo "Menggunakan specialisation: $specialisation (via /specialisation/)"
# Cek apakah menggunakan format 'default-specialname'
elif echo "$system_path" | grep -q "nixos-system-default-.*-[0-9]"; then
    # Ekstrak nama specialisation jika ada format 'specialname' sebelum angka versi
    spec_name=$(echo "$system_path" | grep -Po 'nixos-system-default-\K[^-]*-[^-]*(?=-[0-9])')
    if [ -n "$spec_name" ]; then
        echo "Menggunakan specialisation: $spec_name (via default-specialname)"
    else
        echo "Menggunakan konfigurasi default (tidak ada specialisation)"
    fi
else
    echo "Menggunakan konfigurasi default (tidak ada specialisation)"
fi

echo -e "\nDaftar specialisation yang tersedia:"
if [ -d "/run/current-system/specialisation" ]; then
    for spec in /run/current-system/specialisation/*; do
        if [ -d "$spec" ]; then
            name=$(basename "$spec")
            echo "- $name"
        fi
    done
else
    echo "Tidak ada specialisation yang terdaftar."
fi''
