{ config, lib, pkgs, ... }:

{
  imports = lib.mh.autoImport.subDir ./.;
}
