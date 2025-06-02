# File: home.nix

{ config, pkgs, lib, ... }:

{
  xdg.configFile."lf/icons".source = ./icons;
  
  # Instalasi paket pendukung untuk lf
  home.packages = with pkgs; [
    # Tools untuk preview file
    file
    bat
    pistol
    poppler_utils
    ffmpegthumbnailer
    imagemagick
    chafa       # Untuk terminal yang tidak mendukung icat
    
    # Tools untuk ekstraksi file
    unzip
    unrar
    p7zip
    xdragon
  ];
  
  # Konfigurasi lf file manager
  programs.lf = {
    enable = true;
    
    # Pengaturan dasar
    settings = {
      preview = true;
      hidden = false;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };
    
    # Kunci pintas kustom
    keybindings = {
      "<enter>" = "open";
      "oo" = "open";
      "cc" = "mkdir";
      "do" = "dragon-out";
      "ee" = "$$EDITOR $f";
      "ex" = "extract";
      "V" = ''$${lib.getBin pkgs.bat}/bin/bat --paging=always --theme=gruvbox "$f"'';
      "." = "set hidden!";
      "dD" = "delete";
      "p" = "paste";
      "x" = "cut";
      "y" = "copy";
      "r" = "rename";
      "/" = "search";
      "h" = "updir";
      "?" = "help";
      "q" = "quit";
      "i" = "img_preview"; # Custom command untuk preview gambar
    };
    
    # Perintah kustom
    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
      extract = ''
        ''${{
          set -f
          case $f in
            *.tar.bz|*.tar.bz2|*.tbz|*.tbz2) ${lib.getBin pkgs.gnutar}/bin/tar xjvf $f;;
            *.tar.gz|*.tgz) ${lib.getBin pkgs.gnutar}/bin/tar xzvf $f;;
            *.tar.xz|*.txz) ${lib.getBin pkgs.gnutar}/bin/tar xJvf $f;;
            *.zip) ${lib.getBin pkgs.unzip}/bin/unzip $f;;
            *.rar) ${lib.getBin pkgs.unrar}/bin/unrar x $f;;
            *.7z) ${lib.getBin pkgs.p7zip}/bin/7z x $f;;
          esac
        }}
      '';
      
      mkdir = ''
        ''${{
          printf "Directory Name: "
          read ans
          mkdir -p $ans
        }}
      '';
      
      touch = ''
        ''${{
          printf "File Name: "
          read ans
          ${lib.getBin pkgs.coreutils}/bin/touch $ans
        }}
      '';
      
      img_preview = ''
        ''${{
          # Deteksi apakah terminal mendukung kitty's icat
          if [ -n "$KITTY_WINDOW_ID" ]; then
            ${lib.getBin pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "$2x$3@$4x$5" "$1" < /dev/null > /dev/tty
          else
            ${lib.getBin pkgs.chafa}/bin/chafa -c 256 -s "$2x$3" "$1"
          fi
        }}
      '';
    };
    
    # Konfigurasi tambahan menggunakan pendekatan let...in yang lebih modular
    extraConfig = 
      let 
        previewer = pkgs.writeShellScriptBin "lf-preview" ''
          #!/usr/bin/env bash
          
          FILE="$1"
          WIDTH="$2"
          HEIGHT="$3"
          X="$4"
          Y="$5"
          
          # Deteksi mime type
          MIMETYPE=$(${lib.getBin pkgs.file}/bin/file --mime-type -b "$FILE")
          
          case "$MIMETYPE" in
              text/*)
                  ${lib.getBin pkgs.bat}/bin/bat --color=always --style=numbers --line-range=:500 "$FILE"
                  ;;
              image/*)
                  # Gunakan kitty icat jika tersedia, fallback ke chafa
                  if [ -n "$KITTY_WINDOW_ID" ]; then
                      ${lib.getBin pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${WIDTH}x''${HEIGHT}@''${X}x''${Y}" "$FILE" < /dev/null > /dev/tty
                  else
                      ${lib.getBin pkgs.chafa}/bin/chafa -c 256 -s "''${WIDTH}x''${HEIGHT}" "$FILE"
                  fi
                  ;;
              application/pdf)
                  ${lib.getBin pkgs.poppler_utils}/bin/pdftotext -l 10 -nopgbrk -q -- "$FILE" -
                  ;;
              video/*)
                  ${lib.getBin pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -i "$FILE" -o /tmp/thumbnail.png -s 0
                  
                  if [ -n "$KITTY_WINDOW_ID" ]; then
                      ${lib.getBin pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${WIDTH}x''${HEIGHT}@''${X}x''${Y}" /tmp/thumbnail.png < /dev/null > /dev/tty
                  else
                      ${lib.getBin pkgs.chafa}/bin/chafa -c 256 -s "''${WIDTH}x''${HEIGHT}" /tmp/thumbnail.png
                  fi
                  ;;
              *)
                  # Coba gunakan pistol untuk mime types lainnya
                  if command -v ${lib.getBin pkgs.pistol}/bin/pistol &> /dev/null; then
                      ${lib.getBin pkgs.pistol}/bin/pistol "$FILE"
                  else
                      echo "Tipe file tidak didukung untuk preview: $MIMETYPE"
                      ${lib.getBin pkgs.file}/bin/file --brief "$FILE"
                  fi
                  ;;
          esac
          
          exit 0
        '';
        
        cleaner = pkgs.writeShellScriptBin "lf-cleaner" ''
          #!/usr/bin/env bash
          
          # Bersihkan icat jika menggunakan Kitty
          if [ -n "$KITTY_WINDOW_ID" ]; then
              ${lib.getBin pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
          fi
          
          # Bersihkan terminal apapun
          printf "\033[2J\033[1;1H"
          
          exit 0
        '';
      in ''
        # Konfigurasi previewer dan cleaner
        set previewer ${previewer}/bin/lf-preview
        set cleaner ${cleaner}/bin/lf-cleaner
        
        # Ikon dan warna
        set icons true
        set drawbox true
        
        # Pesan selamat datang
        set ratios 1:2:3
        set info size
        
        # Pengaturan sorting
        set sortby natural
        set reverse false

        # Custom key annotations untuk help menu
        cmap <tab> cmd-menu-complete
        cmap <backtab> cmd-menu-complete-back
      '';
  };
  
  # Konfigurasi tambahan untuk integrasi dengan media viewer lainnya
  xdg.configFile = {
    # Konfigurasi pistol untuk mendukung format lain
    "pistol/pistol.conf".text = ''
      text/* ${lib.getBin pkgs.bat}/bin/bat --paging=never --color=always --style=plain %pistol-filename%
      application/json ${lib.getBin pkgs.bat}/bin/bat --paging=never --color=always --style=plain %pistol-filename%
      application/javascript ${lib.getBin pkgs.bat}/bin/bat --paging=never --color=always --style=plain %pistol-filename%
      application/x-ndjson ${lib.getBin pkgs.bat}/bin/bat --paging=never --color=always --style=plain %pistol-filename%
      application/xml ${lib.getBin pkgs.bat}/bin/bat --paging=never --color=always --style=plain %pistol-filename%
    '';
  };
}
