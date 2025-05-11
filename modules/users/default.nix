{ lib, ... }:

{
  imports = lib.mh.autoImport.flatDir ./.;
}
