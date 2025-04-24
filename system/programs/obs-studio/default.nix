{ config, pkgs, ... }:

{
 #  programs.obs-studio = {
 #    package = pkgs.obs-studio;
 #    enable = true;
	# enableVirtualCamera = true;
	# plugins = with pkgs.obs-studio-plugins; [
	#   obs-backgroundremoval
	#   obs-pipewire-audio-capture
	#   obs-vkcapture
	#   # obs-v4l2sink # untuk output ke perangkat v4l2 (virtual camera)
	#   input-overlay
	# ];
 #  };
	#
 #  # Aktifkan modul kernel v4l2loopback untuk dukungan webcam virtual
 #  boot.kernelModules = [ "v4l2loopback" ];
 #  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
	#
 #  # Konfigurasi v4l2loopback untuk webcam virtual
 #  boot.extraModprobeConfig = ''
 #    options v4l2loopback devices=1 video_nr=10 card_label="OBS Virtual Camera" exclusive_caps=1
 #  '';
 #  
 #  security.rtkit.enable = true;
 #  services.pipewire = {
 #    enable = true;
	# alsa.enable = true;
	# alsa.support32Bit = true;
	# pulse.enable = true;
	# jack.enable = true;
 #  };
	#
 #  environment.systemPackages = with pkgs; [
 #    v4l-utils # Untuk konfig webcam
	# # pulsemixer # setting autio
	# ffmpeg # pengkodean video
	# zoom-us
 #  ];
	#
 #  users.users.mh = {
 #    extraGroups = [ "video" "audio" ];
 #  };
}
