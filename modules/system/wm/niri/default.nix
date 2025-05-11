{ config, lib, pkgs, ... }:

{
  programs.niri = {
    enable = true;
	package = pkgs.niri;
  };

  # X11 windows system
  services.xserver.enable = false;

  # KDE Plasma DE
  services.displayManager.enable = false;
  services.displayManager.sddm.enable = false;
  services.desktopManager.plasma6.enable = false;
  
 #  services.displayManager.sessionPackages = [
 #    pkgs.niri
	# pkgs.wayland
 #  ];
 #  services.displayManager.defaultSession = "wayland+niri";
  
  
  services.greetd = {
  enable = true;
  settings = {
    default_session = {
      command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet --cmd "dbus-run-session ${pkgs.niri}/bin/niri"
      '';
      user = "mh";
    };
  };
};
  environment.sessionVariables = {
  XDG_SESSION_TYPE = "wayland";
  XDG_CURRENT_DESKTOP = "niri";
  MOZ_ENABLE_WAYLAND = "1";
  QT_QPA_PLATFORM = "wayland";
  SDL_VIDEODRIVER = "wayland";
  CLUTTER_BACKEND = "wayland";
};

programs.sway.enable = true;  # Mengaktifkan komponen Wayland dasar
xdg.portal = {
  enable = true;
  wlr.enable = lib.mkForce true;
  extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
};

  programs.xwayland.enable = true;

  programs.waybar.enable = true;

  environment.systemPackages = with pkgs; [
    wayland
  ];
}
