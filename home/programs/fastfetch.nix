{ ... }:

{
  programs.fastfetch = {
	enable = true;
	settings = {
	    logo = {
	    	source = "~/.local/share/fastfetch/images/chillGuy.png"; # child-guy.png / nixos-chill.png
	    	type = "kitty";
    	  	height = 35;
	      	padding = {
    			top = 1;
	      	};
    	};
	    display = {
	          separator = " ➜  "; # \u279c
	    };
    	modules = [
	        "break"
	        "break"
        	"break"
			{
	            type = "title";
	            color = {
	                user = "32";
	                at = "37";
                	host = "32";
            	};
        	}
	        #{
	        #    type = "command";
	        #    key = " ├  ";
	        #    keyColor = "32";
	        #    text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
	        #}
	        {
	            type = "uptime";
	            key = " └  ";
	            keyColor = "32";
	        }
	        "break"
			{
      			type = "os";
			    key = " OS  ";
      			keyColor = "31";
		    }
		    {
		      	type = "kernel";
      			key = " ├  ";
      			keyColor = "31";
    		}
    		{
      			type = "packages";
      			format = "{} (nixpkgs)";
      			key = " ├ 󰏖 ";
      			keyColor = "31";
    		}
    		{
      			type = "shell";
      			key = " └  ";
      			keyColor = "31";
    		}
    		"break"
    		{
      			type = "wm";
      			key = "WM   ";
      			keyColor = "34";
    		}
    		{
      			type = "wmtheme";
      			key = " ├ 󰉼 ";
      			keyColor = "34";
    		}
    		{
      			type = "icons";
      			key = " ├ 󰀻 ";
      			keyColor = "34";
    		}
    		{
      			type = "cursor";
      			key = " ├  ";
      			keyColor = "34";
    		}
    		{
      			type = "terminal";
      			key = " ├  ";
      			keyColor = "34";
    		}
    		{
      			type = "font";
      			key = " └  ";
      			keyColor = "34";
    		}
    		"break"
    		{
      			type = "host";
      			format = "{5} {1} Type {2}";
      			key = "PC   ";
      			keyColor = "33";
    		}
    		{
      			type = "cpu";
      			format = "{1} ({3}) @ {7} GHz | {2}";
      			key = " ├  ";
      			keyColor = "33";
    		}
    		{
      			type = "gpu";
      			format = "{1} {2} @ {12} GHz | {3}";
      			key = " ├ 󰢮 ";
      			keyColor = "33";
    		}
    		{
      			type = "memory";
      			key = " ├  ";
      			keyColor = "33";
    		}
    		{
      			type = "swap";
      			key = " ├ 󰓡 ";
      			keyColor = "33";
    		}
    		{
      			type = "disk";
      			key = " ├ 󰋊 ";
      			keyColor = "33";
    		}
    		{
      			type = "monitor";
      			key = " ├  ";
      			keyColor = "33";
    		}
	        {
    	        type = "colors";
        	    symbol = "triangle";
			    paddingLeft = 1;
				key = " └ 󰛪 ";
				keyColor = "33";
				height = 20;
				block = {
					# width = 30;
					range = [ 0 15 ];
				};
	        }
    		"break"
    		"break"
  		];
	};
  };
}
