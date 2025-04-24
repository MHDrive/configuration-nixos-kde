{ lib, ... }:

let
  filter = name: value: value == "regular" && name != "default.nix" && lib.hasSuffix ".nix" name;
  imports = lib.mapAttrsToList (name: value: ./. + ("/" + name)) (lib.filterAttrs filter (builtins.readDir ./.));
in 
{
  inherit imports;
  programs.home-manager.enable = true;
}
