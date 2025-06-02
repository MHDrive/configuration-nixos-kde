{ pkgs, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        # Font dengan ukuran yang lebih proporsional
        font = "JetBrainsMono Nerd Font:size=11";
        
        # Layout yang lebih baik
        lines = 15;
        width = 45;
        
        # Padding yang lebih seimbang
        horizontal-pad = 20;
        vertical-pad = 15;
        inner-pad = 8;
        
        # Border dan radius yang lebih halus
        border-width = 2;
        border-radius = 12;
        
        # Icon dan prompt
        icon-theme = "Papirus-Dark";
        icons = true;
        prompt = "❯ ";
        
        # Terminal dan layer
        terminal = "foot";
        layer = "overlay";
        anchor = "center";
        
        # DPI awareness
        dpi-aware = true;
        
        # Performance tweaks
        fuzzy = true;
        show-actions = true;
        tabs = 4;
      };
      
      colors = {
        # Background dengan transparansi yang lebih halus
        background = "1a1b26ee";
        text = "c0caf5ff";
        
        # Warna untuk match/highlight
        match = "7aa2f7ff";
        selection = "24283bff";
        selection-text = "c0caf5ff";
        selection-match = "bb9af7ff";
        
        # Border yang kontras tapi tidak mencolok
        border = "414868ff";
        
        # Placeholder text
        placeholder = "565f89ff";
      };
      
      border = {
        width = 2;
        radius = 12;
      };
      
      key-bindings = {
        # Navigation yang intuitif
        cancel = "Escape Control+c";
        execute = "Return KP_Enter";
        execute-or-next = "Tab";
        
        # Movement
        cursor-left = "Left";
        cursor-right = "Right";
        cursor-home = "Home";
        cursor-end = "End";
        
        # Selection
        prev = "Up";
        next = "Down";
        
        # Deletion
        delete-prev = "BackSpace";
        delete-next = "Delete";
        delete-line = "Control+u";
        
        # Page navigation
        prev-page = "Page_Up";
        next-page = "Page_Down";
        
        # First/last
        first = "Control+Home";
        last = "Control+End";
      };
      
      dmenu = {
        # Mode untuk dmenu compatibility
        exit-immediately-if-empty = false;
      };
    };
  };
}
