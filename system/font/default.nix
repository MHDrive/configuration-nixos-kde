{ config, lib, pkgs, ... }:

{
    fonts = {
		fontDir.enable = true;
		enableDefaultPackages = true;
		packages = with pkgs; [
			(nerdfonts.override {
				fonts = [
				"JetBrainsMono" # Font coding utama dengan ligatures
				"FiraCode"      # Alternatif populer dengan ligatures
				"Hack"          # Font monospace klasik
				];
			})

			# Font UI dasar
			inter             # Font UI modern
			noto-fonts        # Font umum untuk dukungan bahasa luas
			noto-fonts-emoji  # Dukungan emoji
		
			# Font untuk dokumen
			dejavu_fonts      # Font universal dengan dukungan karakter luas
			liberation_ttf    # Pengganti untuk font Microsoft
		
			# Font khusus
			font-awesome      # Icon untuk UI
		];

		# Konfigurasi fontconfig yang sederhana
		fontconfig = {
			defaultFonts = {
				serif = [ "DejaVu Serif" "Liberation Serif" ];
				sansSerif = [ "Inter" "DejaVu Sans" "Liberation Sans" ];
				monospace = [ "JetBrainsMono Nerd Font" "FiraCode Nerd Font" "Hack Nerd Font" "DejaVu Sans Mono" ];
				emoji = [ "Noto Color Emoji" ];
			};
		};
    };
}