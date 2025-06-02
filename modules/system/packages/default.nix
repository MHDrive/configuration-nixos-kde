{ config, lib, pkgs, ... }:

{
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
   yt-dlp  # downloader yt via terminal yt-dlp "url"

   lf pcmanfm gvfs # file manager
   # android-file-transfer jmtpfs # MPT support for smartphone
   usbutils
   # mtpfs
   simple-mtpfs


   eza # alternatif modern tree/ls
   libnotify # notify-send "teks"
   pavucontrol # control sound/audio (pulseaudio)
   blueman # bluetooth manager 
   ags # clock and calender
   wlogout # logout manager
   swww  # wallpaper cli
   wl-clipboard  # copy paste for wayland

   # nodejs_23
   nodejs_24
   gnome-calendar
   foot
   alacritty
  ]);
}
