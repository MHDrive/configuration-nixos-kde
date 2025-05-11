{ pkgs, ... }:

{
  imports = [
    ./mako
    # ./waybar
  ];
  home.packages = with pkgs; [
    kitty	   # Terminal
    swaylock    # Screen Locker
    fuzzel      # App launcher
    wl-clipboard # Clipboard
	swayidle    # Idle management
	waybar      # Status bar (opsional)
	mako        # Notification daemon
	# heynote
  ];

 #  home.sessionVariables = {
 #    MOZ_ENABLE_WAYLAND = "1";
	# QT_QPA_PLATFORM = "wayland";
	# SDL_VIDEODRIVER = "wayland";
 #  };
}
