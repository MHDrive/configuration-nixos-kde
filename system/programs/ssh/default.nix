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
        User git
        IdentityFile ~/.ssh/github_key
        IdentitiesOnly yes
    '';
    askPassword = "${pkgs.ksshaskpass.out}/bin/ksshaskpass";
  };
  
  # Menambahkan script aktivasi untuk memulai agent dan menambahkan kunci
  system.activationScripts.sshSetup = ''
    # Memastikan direktori dan file memiliki izin yang benar
    chmod 700 /home/mh/.ssh
    chmod 600 /home/mh/.ssh/github_key
    chmod 644 /home/mh/.ssh/github_key.pub
    
    # Memulai ssh-agent jika belum berjalan
    if [ -z "$SSH_AUTH_SOCK" ]; then
      eval "$(ssh-agent -s)" > /dev/null
    fi
    
    # Menambahkan kunci
    ssh-add /home/mh/.ssh/github_key 2>/dev/null || true
  '';

  environment.variables.SSH_ASKPASS_REQUIRE = "prefer";
}
