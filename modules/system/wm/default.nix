{ lib, ... }:

{
  imports = lib.mh.autoImport.subDir ./.;
}
