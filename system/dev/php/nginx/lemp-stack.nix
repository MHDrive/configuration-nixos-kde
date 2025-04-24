{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dev.php.nginx;
in 
{
  options.dev.php.nginx = {
  	lempStack = mkEnableOption "nginx lamp stack for php";
	database = mkOption {
      type = types.nullOr (types.enum [ "mysql84" "mariadb" ]);
      default = null;
      example = "mysql84";
      description = "Pilih database backend untuk LEMP stack.";
	};
  };
  config = mkIf cfg.lempStack (mkMerge [
    {
      services.nginx = {
        enable = true;
		user = "mh";
		group = "users";
        virtualHosts."localhost" = {
          # enableACME = true;
          # forceSSL = true;
          root = "/srv/Web/example";
          locations."~ \\.php$".extraConfig = ''
            fastcgi_pass unix:/run/phpfpm/mypool.sock;
            fastcgi_index index.php;
          '';
        };
      };

      services.phpfpm = {
	    pools.mypool = {
          user = "mh";
		  group = "users";
          settings = {
            "pm" = "dynamic";
            "listen.owner" = config.services.nginx.user;
            "pm.max_children" = 5;
            "pm.start_servers" = 2;
            "pm.min_spare_servers" = 1;
            "pm.max_spare_servers" = 3;
            # "pm.max_requests" = 500;
          };
        };
	  };

	  networking = {
	    firewall = {
	      allowedTCPPorts = [ 80 443 3306 ]; # Allow HTTP, HTTPS, MariaDB
		};
	    hosts = {
		  "127.0.0.1" = [
		    "localhost"
		  ];
		};
		# extraHosts = ''
		# 127.0.0.1 myproject.test
		# '';

	  };
    }

    (mkIf (cfg.database != null) {
      services.mysql = {
        enable = true;
        package = {
          mysql84 = pkgs.mysql84;
          mariadb = pkgs.mariadb;
        }.${cfg.database};
      };
    })
  ]);
}
# example usage
# dev.php.nginx = {
#   lempStack = true;
#   database = "mariadb"; # atau "mysql84" default null
# };
