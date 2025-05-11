{ config, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
    package = pkgs.direnv;
    silent = false;  # Set ke true jika Anda tidak ingin melihat pesan "direnv: loading/unloading"
    loadInNixShell = true;  # Aktifkan direnv di dalam nix-shell
    
    # Integrasi dengan shell
    enableBashIntegration = true;
    enableZshIntegration = true;
    # enableFishIntegration = true;
    
    # Konfigurasi tambahan untuk .direnvrc
    direnvrcExtra = ''
      # Contoh: cache nix shell untuk kinerja yang lebih baik
      use_nix() {
        watch_file flake.nix
        watch_file flake.lock
        if [ -f flake.nix ]; then
          eval "$(nix print-dev-env)"
        else
          use flake
        fi
      }
    '';
  };
}
