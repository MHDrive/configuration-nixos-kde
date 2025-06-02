{ config, lib, pkgs, ... }:

{
  programs.niri.enable = true;

  xdg = {
    autostart.enable = true;
	menus.enable = true;
	mime.enable = true;
	icons.enable = true;
    portal = {
      enable = true;
    };
  };
  services = {
  
	xserver = {
	  enable = true;
	  displayManager = {
	    sessionPackages = [ pkgs.niri ];
		defaultSession = "niri";
		gdm = {
		  enable = true;
		  wayland = true;
		};
	  };

	};
  };

  environment = {
    variables = {
	  XCURSOR_THEME = "default";
	  XCURSOR_SIZE = 24;
	};
    systemPackages = with pkgs; [
      xdg-utils
      niri
	  xwayland
	  xwayland-satellite
	  wl-clipboard
	  swaylock    # Screen locker
      swayidle    # Idle management
	  waybar      # Status bar (opsional)
	  mako        # Notification daemon
	  kanshi      # Output manager
    ];
  };


  security.polkit.enable = true;

  security.pam.services.swaylock = {};
  programs = {
    dconf.enable = true;
	bash.enableCompletion = true;
	zsh.enableCompletion = true;
	fish.enable = true;
  };
  fonts.enableDefaultPackages = true;

  services.dbus.enable = true;

  services.pipewire = {
    enable = true;
	alsa.enable = true;
	pulse.enable = true;
  };

}
