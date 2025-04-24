{ lib }:

{
  autoImport = (import ./auto-import.nix { inherit lib; }).autoImport;
}
