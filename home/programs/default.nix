{ lib, ... }:

{
  imports = [
    ./fastfetch.nix
    ./git.nix
    ./lf.nix
    ./starship.nix
    ./zsh.nix
  ];

  programs.home-manager.enable = true;
}
