function show_banner() {
          local color_red="\e[31m"
          local color_green="\e[32m"
          local color_yellow="\e[33m"
          local color_blue="\e[34m"
          local color_magenta="\e[35m"
          local color_cyan="\e[36m"
          local color_reset="\e[0m"
          
          echo -e "\n$color_magenta
          ███╗   ██╗██╗██╗  ██╗ ██████╗ ███████╗
          ████╗  ██║██║╚██╗██╔╝██╔═══██╗██╔════╝
          ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║███████╗
          ██║╚██╗██║██║ ██╔██╗ ██║   ██║╚════██║
          ██║ ╚████║██║██╔╝ ██╗╚██████╔╝███████║
          ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
          $color_reset"
          
          echo -e "$color_cyan╭─────────── System Information ───────────╮$color_reset"
          echo -e "$color_red  → Kernel: $(uname -sr)" $color_reset
          echo -e "$color_blue  → Uptime: $(awk '{print int($1/86400)"d " int(($1%86400)/3600)"h " int(($1%3600)/60)"m"}' /proc/uptime)" $color_reset
          echo -e "$color_magenta  → Shell: $(basename $SHELL)" $color_reset
          
          echo -e "$color_cyan╰──────────────────────────────────────────╯$color_reset\n"
      }
      
      # Call Banner
      show_banner
      
      # For ls
      export LS_COLORS="di=1;34:ln=1;36:so=1;31:pi=1;33:ex=1;32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
      
      # for man pages
      export LESS_TERMCAP_mb=$'\e[1;32m'
      export LESS_TERMCAP_md=$'\e[1;32m'
      export LESS_TERMCAP_me=$'\e[0m'
      export LESS_TERMCAP_se=$'\e[0m'
      export LESS_TERMCAP_so=$'\e[01;33m'
      export LESS_TERMCAP_ue=$'\e[0m'
      export LESS_TERMCAP_us=$'\e[1;4;31m'
