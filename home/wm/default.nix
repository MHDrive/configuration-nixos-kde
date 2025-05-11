{ lib, ... }:

{
  # imports = lib.mh.autoImport.subDir ./.;
  imports = [
    ./niri/default.nix
  ];
}
