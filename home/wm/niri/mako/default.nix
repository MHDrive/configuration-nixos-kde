{ pkgs, ... }:

{
  services.mako = {
    enable = true;

	font = "Fira Code 10";
	backgroundColor = "#285577FF";
	textColor = "#FFFFFFFF";
	borderColor = "#4C7899FF";

	#ukuran dan bentuk
	width = 300;
	height = 100;
	borderSize = 2;
	borderRadius = 5;
	padding = "10";
	margin = "10";

	# perilaku notifikasi
	defaultTimeout = 4000;
	ignoreTimeout = false;
	maxVisible = 5;
	sort = "-time";

	# Ikon 
	icons = true;
	maxIconSize = 32;
	iconPath = "${pkgs.papirus-icon-theme}/share/icons/Papirus";

	# Format notifikasi 
	markup = true;
	format =  "%s\\n%b"; # "<b>%s</b>\\n%b";

    # Posisi layar 
	anchor = "top-right";
	layer = "overlay";
	output = "DP-1";

	# Grup notifikasi
	# groupBy =

	actions = true;

	# extraConfig = ''
 #      #contoh konfigurasi tambahan
	#   [mode=do-not-disturb]
	#   invisible=1
	# '';
  };
}
