{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    
	settings = {
	  
	};
    # Gunakan systemd dengan target yang benar
    # systemd = {
    #   enable = false;
    #   target = "graphical.target";  # Target yang tersedia di sistem Anda
    # };

   

    style = ''
      * {
        border: none;
        font-family: "Fira Code", "Font Awesome 6 Free";
        font-size: 12px;
      }

      window#waybar {
        background: rgba(30, 30, 46, 0.9);
        color: #cdd6f4;
        border-bottom: 1px solid rgba(100, 100, 100, 0.5);
      }   
    '';
  };

  # Memastikan Waybar dimulai setelah Niri
  # systemd.user.services.waybar.Service = {
  #   ExecStartPre = "${pkgs.coreutils}/bin/sleep 1";  # Jeda singkat untuk memastikan Niri siap
  # };
}
