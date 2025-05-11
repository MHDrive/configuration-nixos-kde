{ ... }:

{
  xdg.configFile."scripts/waybar/launch.sh" = {
    text = ''
    #!/bin/bash
    #                    __
    #  _    _____ ___ __/ /  ___ _____
    # | |/|/ / _ `/ // / _ \/ _ `/ __/
    # |__,__/\_,_/\_, /_.__/\_,_/_/
    #            /___/
    #
    #
    pkill waybar
    #
    sleep 0.5
    
    #
    if [[ $USER = "mh" ]]; then
	waybar &
    # waybar -c ~/dotfiles/.config/waybar/config -s ~/dotfiles/.config/waybar/style.css &
    else
    # default
    	waybar &
    fi
    '';
    executable = true;
  };
}
