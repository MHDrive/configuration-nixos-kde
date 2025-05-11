{ pkgs, lib, config, ... }:

let
  cfg = config.users.users.mh.shell;
in 
  lib.mkIf (cfg.name == pkgs.fish.name) {
  programs.fish.enable = true;
}
