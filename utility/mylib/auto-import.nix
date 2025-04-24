{ lib }:

let
  inherit (builtins) readDir pathExists;
  inherit (lib) filterAttrs mapAttrsToList hasSuffix;
in
{
  autoImport = {
    flatDir = 
      dir:
      let
        entries = readDir dir;
        condition = name: type: 
                    type == "regular" 
                    && hasSuffix ".nix" name 
                    && name != "default.nix";
        filtered = filterAttrs condition entries;
        toPath = name: _: dir + "/${name}";
      in 
        mapAttrsToList toPath filtered;
  
    subDir =
      dir:
      let
        entries = readDir dir;
        condition = name: type:
                    type == "directory"
                    && pathExists (dir + "/${name}/default.nix");
        filtered = filterAttrs condition entries;
        toPath = name: _: dir + "/${name}";
      in 
        mapAttrsToList toPath filtered;

    allDir = 
      dir:
      let
        entries = readDir dir;
        condition = name: type: 
                    if type == "directory" then 
                      pathExists (dir + "/${name}/default.nix")
                    else
                      type == "regular"
                      && hasSuffix ".nix" name
                      && name != "default.nix";
        filtered = filterAttrs condition entries;
        toPath = name: type: 
                 if type == "regular" then 
                   dir + "/${name}"
                 else
                   dir + "/${name}/default.nix";
      in 
        mapAttrsToList toPath filtered;
  }; 
}

