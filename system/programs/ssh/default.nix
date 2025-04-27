{ config, lib, pkgs, ... }: {
  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      # Pertahankan koneksi agar tetap hidup
      Host *
        ServerAliveInterval 60
        ServerAliveCountMax 2
      
      # Konfigurasi untuk GitHub
      Host github.com
	    HostName github.com
        User git
        IdentityFile ~/.ssh/github_key
        IdentitiesOnly yes
    ''; 
  };
}
