{ config, lib, pkgs, ... }:

let
  phpMyAdmin = pkgs.fetchzip {
    url = "https://files.phpmyadmin.net/phpMyAdmin/5.2.2/phpMyAdmin-5.2.2-all-languages.tar.xz";
	sha256 = "sha256-zmwPMCVo/FekXFHFHRhvLfrq+Mt4nKoe/4r8d5vQxoQ=";
	stripRoot = false;
  };
in 	
{
  imports = [
	./../certs
  ];
  services = {
    certs = {
	  "valet-wildcard" = {
	    cname = "*.test";
		alt = [ "DNS:*.test" "DNS:test" ];
	  };
	};

	phpfpm = {
	  phpPackage = pkgs.php84;
	  phpOptions = ''
	    date.timezone = "Asia/Makassar";
	    display_errors = on;
	  '';
	  pools = { 
	    valet = {
          user = "nobody";
		  # socket = "/run/phpfpm/valet.sock";
	      phpEnv."PATH" = lib.makeBinPath [ config.services.phpfpm.phpPackage ];
          settings = {
            "pm" = "dynamic";
            "listen.owner" = config.services.nginx.user;
            "pm.max_children" = 32;
            "pm.start_servers" = 2;
            "pm.min_spare_servers" = 2;
            "pm.max_spare_servers" = 5;
            "pm.max_requests" = 500;
			"php_admin_value[error_log]" = "stderr";
			"php_admin_flag[log_errors]" = true;
			"catch_workers_output" = true;
          };
        };
		phpmyadmin = {
		  user = "nobody";
		  # socket = "/run/phpfpm/phpmyadmin.sock";
		  settings = {
			"pm" = "dynamic";
            "listen.owner" = config.services.nginx.user;
            "pm.max_children" = 5;
            "pm.start_servers" = 1;
            "pm.min_spare_servers" = 1;
            "pm.max_spare_servers" = 3;
            "pm.max_requests" = 200;
            "php_admin_value[error_log]" = "stderr";
            "php_admin_flag[log_errors]" = true;
            "catch_workers_output" = true;
		  };
		};
	  };
	};
    nginx = {
      enable = true;
      virtualHosts = {
        # "~^(?<domain>.+)\\.test$" = {
		"*.test" = {
		  serverName = "~^(?<domain>.+)\\.test$";
          root = "/srv/server/local/$domain";
		  addSSL = true;
		  sslCertificate = config.services.certs."valet-wildcard".cert;
		  sslCertificateKey = config.services.certs."valet-wildcard".key;
		  extraConfig = ''
            charset utf-8;	
          '';
          locations."/" = {
            index = "public/index.php index.php index.html index.htm";
            tryFiles = "$uri $uri/ /index.php?$query_string";
            # root = "/srv/www/$domain";
          };
		  locations."path" = {
		    root = "/srv/www";
		  };
          locations."~ \\.php$" = {
            extraConfig = ''
              fastcgi_split_path_info ^(.+\\.php)(/.+)$;
              fastcgi_pass unix:${config.services.phpfpm.pools.valet.socket};
              fastcgi_index index.php;
              include ${pkgs.nginx}/conf/fastcgi_params;
              fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            '';
          };
        };
		"phpmyadmin.test" = {
		  root = "${phpMyAdmin}";
		  locations = { 
			"/" = {
			  index = "index.php";
			  tryFiles = "$uri $uri/ /index.php?$query_string";
			};

			"~ \\.php$" = {
              extraConfig = ''
                fastcgi_split_path_info ^(.+\\.php)(/.+)$;
              	fastcgi_pass unix:${config.services.phpfpm.pools.phpmyadmin.socket};
              	fastcgi_index index.php;
              	include ${pkgs.nginx}/conf/fastcgi_params;
              	fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
              	fastcgi_param DOCUMENT_ROOT $document_root;
              	fastcgi_intercept_errors on;
              	fastcgi_buffer_size 128k;
              	fastcgi_buffers 4 256k;
              	fastcgi_busy_buffers_size 256k;
              	fastcgi_read_timeout 300;
              '';
          	};
		  };
		};
	  };
	  # appendHttpConfig = ''
	  #   server {
   #        server_name *.test;
   #        
   #        location ~ ^/([a-z0-9]+)/ {
   #          alias /srv/http/$1/;
   #          index /public/index.php index.php index.html;
   #        }
   #      }
	  # '';
    };

    dnsmasq = {
      enable = true;
      settings = {
        address = "/test/127.0.0.1";
      };
    };

    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
  };

  environment.systemPackages = with pkgs; [
	config.services.phpfpm.phpPackage
  ];

  system.activationScripts.createWebDirectories = ''
	# pastikan direktori ada
	mkdir -p /srv/server/local
	mkdir -p /srv/www

    # rubah permission
	# chmod 755 /srv/server/local
	# chmod 755 /srv/www

	# Pastikan direktori Projects ada di home user
	mkdir -p /home/mh/Projects
	chown mh:users /home/mh/Projects

	# rubah owner folder vhost
	chown -R mh:users /srv/www

	# Buat symlink
	ln -sf /srv/www /home/mh/Projects/ 2>/dev/null || true

	# Rubah owner symlink
	# chown -h mh:users /home/mh/Projects/http
  '';

  systemd.services.valet-path-symlink = {
    description = "Auto symlink new folders with lowercase names";
    path = [ pkgs.inotify-tools pkgs.coreutils pkgs.bash pkgs.findutils ];
    script = ''
      #!/bin/bash
    
      SOURCE_DIR="/srv/www"
      TARGET_DIR="/srv/server/local"
      
      # Fungsi untuk membuat symlink lowercase
      create_lowercase_symlinks() {
        echo "Scanning for new directories..."
        for dir in "$SOURCE_DIR"/*; do
          if [ -d "$dir" ]; then
            dirname=$(basename "$dir")

		    lowercase=$(echo "$dirname" | tr '[:upper:]' '[:lower:]')
            target="$TARGET_DIR/$lowercase"
          
            # Buat symlink jika belum ada atau jika target tidak valid
            if [ ! -e "$target" ] || [ "$(readlink -f "$target")" != "$(readlink -f "$dir")" ]; then
              echo "Creating symlink: $dir -> $target"
              ln -sf "$dir" "$target"
            fi
          fi
        done
      }
    
      # Fungsi untuk membersihkan symlink rusak
      clean_broken_symlinks() {
        echo "Cleaning broken symlinks..."
        find "$TARGET_DIR" -type l | while read link; do
          target=$(readlink -f "$link" 2>/dev/null || echo "")
          if [ ! -d "$target" ]; then
            echo "Removing broken symlink: $link -> $target"
            rm "$link"
          fi
        done
      }
    
      create_lowercase_symlinks
      clean_broken_symlinks
    
      # Monitor folder untuk perubahan
      echo "Monitoring $SOURCE_DIR for changes..."
      inotifywait -m -e create -e delete -e moved_to -e moved_from "$SOURCE_DIR" | while read path action file; do
        echo "Detected $action on $file"
        # Tunggu sebentar untuk memastikan operasi file selesai
        sleep 1
        create_lowercase_symlinks
        clean_broken_symlinks
      done
    '';
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "root";
      Restart = "always";
      RestartSec = "5s";
    };
  };
}

