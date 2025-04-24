# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
	    ./hardware/asus/x441uv
	    ./programs
	    ./../de/kde/plasma6
		./dev/php
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "default"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Makassar";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  # services.fractalart.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mh = {
    isNormalUser = true;
    description = "MH";
	shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "phpdemo" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };
  # users.defaultUserShell = pkgs.zsh;

  # Install firefox.
 #  programs.firefox.enable = true;
 #  programs.starship.enable = true;
 #  programs.steam = {
	# enable = true;
	# remotePlay.openFirewall = true;
	# localNetworkGameTransfers.openFirewall = true;
 #  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  #  vscode
  #  git
  
  # ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #nix.settings = {
    #substituters = [
	#	"https://hyprland.cachix.org"
	#	"https://fmcachix.cachix.org"
	#];
    #trusted-public-keys = [
	#	"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
	#	"fmcachix.cachix.org-1:Z5j9jk83ctoCK22EWrbQL6AAP3CTYnZ/PHljlYSakrw="
	#];
  #};
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
 
  environment.systemPackages = import ./my-scripts { inherit pkgs;} ++
  (with pkgs; [
   vscode
   git
   tree
   vim
   neovim
   mesa-demos
   libreoffice-qt6-fresh
   pcsx2
   jstest-gtk
   telegram-desktop
   htop
   spotify
   bat
   flatpak
   lshw
   vlc
   discord
   lua54Packages.lua
   ripgrep
   fd
   pciutils #collection of programs and manipulating config of PCI devices
   mangohud #monitoring fps, temp, gpu/cpu and mpre
   vulkan-loader
   # inputs.xdmanpkgs.packages.${pkgs.system}.xdman
   # fmpkgs.xdman
   # google-chrome
   bindfs
   ntfs3g
  ]);

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.flatpak.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
