{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        modules-left = ["custom/launcher" "cpu" "memory" "disk" "niri/workspaces"];
	modules-center = ["clock"];
	modules-right = ["keyboard-state" "wlr/taskbar" "niri/language" "backlight" "pulseaudio" "battery" "custom/power"];

	
	# "bluetooth" = {};

 	"niri/language" = {
	  format = "  {1}";
          tooltip = false;
	}; 
	
	"battery" = {
   	  bat = "BAT0";
	  interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "{icon}󱐋 {capacity}%";
          format-plugged = "{icon}󱐋 {capacity}%";
          format-alt = "{icon}  {time}";
          format-icons = [" " " " " " " " " "];
	  max-lenght = 25;
	};

	"cpu" = {
	  interval = 15;
	  format = "  {}%";
          max-length = 10;
	};

	"memory" = {
          interval = 30;
          format = "  {}%";
          max-length = 10;
    	};

	"disk" = {
          interval = 30;
          format = "  {percentage_used}%";
          path = "/";
    	};

	#"tray" = {
	#  icon-size = 18;
	#  spacing = 10;
	#};

	"wlr/taskbar" = {
	  format = "{icon}";
	  icon-size = 20;
	  tooltip-format = "{title}";
	  on-click = "activate";
	  spacing = 10;
	};
	
	"backlight" = {
	  device = "intel_backlight";
	  format = "{icon} {percent}%";
	  format-icons = ["" ""];
	};

	"custom/launcher" = {
	  format = " ";
	  on-click = "fuzzel";
	  tooltip = false;
	  
	};

	"custom/power" = {
	  format = "";
          on-click = "wlogout";
          tooltip = false;
	};

	"niri/workspaces" = {
	  format = "{icon}";
	  on-click = "activate";
	  tooltip = false;
	  active-only = false;
	  all-outputs = true;
	  format-icons = {
	    "1" = "";
	    "2" = "";
	    "3" = "";
	    "4" = "";
	    urgent = "";
            active = "";
            default = "";
	  };
	};

	"clock" = {
	  format = "  {:%A - %B %d, %Y - %R}";
	  tooltip = false;
	};

	

	"keyboard-state" = {
	  numlock = false;
          capslock = true;
          format = "{icon} {name}";
          format-icons = {
            locked = "";
            unlocked = "";
	  };
	};
	
	"pulseaudio" = {
	  tooltip = false;
	  sroll-step = 5;
	  format = "{icon} {volume}%";
	  format-muted = "󰝟  {format_source}";
	  format-bluetooth = "{volume}%  {icon}󰂯 {format_s
ource}";
	  format-bluetooth-muted = "󰝟  {icon}󰂯 {for
mat_source}";
	  format-source = "{volume}% 󰍬";
	  format-source-muted = "󰍭";
	  format-icons = {
	    headphone = "";
	    headset = "";
	    phone = "";
	    default = ["" " " " "];
	  };
	  on-click = "pavucontrol";
	};
      };
    };
    style = ./style.css;
    # systemd.enable = true;
  };
}
