{ pkgs, lib, config, ... }:

let
  cfg = config.users.users.mh.shell;
in 
  lib.mkIf (cfg.name == pkgs.zsh.name) {
  programs.zsh.enable = true;
}
