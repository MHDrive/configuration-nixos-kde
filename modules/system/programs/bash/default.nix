{ lib, ... }:

{
  programs.bash = {
	blesh.enable = true;
	vteIntegration = true;
	shellAliases = {
		c = "clear";
		nrs = "nixos-rebuild switch --show-trace --verbose"; 
		nrdb = "nixos-rebuild dry-build --show-trace --verbose"; 
		nrt = "nixos-rebuild dry-build --show-trace --verbose";
		nrda = "nixos-rebuild dry-activate --verbose --show-trace";
		nrbv = "nixos-rebuild build-vm --verbose --show-trace";
		nrb = "nixos-rebuild boot --verbose --show-trace";

		# GREP_COLOR=bright yellow on black bg.
		# use GREP_COLOR=7 to highlight whitespace on black terminals
		# LANG=C for speed. See also: http://www.pixelbeat.org/scripts/findrepo
		grep = "GREP_COLOR='mt=1;33;40' LANG=C grep --color=auto"; 
		please = "sudo env PATH=$PATH"; # 
		".." = "cd ..";	  # go to parent dir
		"..." = "cd ../.."; # go to grandparent dir
		l = "ls"; 		 # list files
		"l." = "ls -d .*"; # list hidden files
		ll = "ls -lhrt"; # extra info compared to "l"
		lld = "ls -lUd */";  #list directories
		la = "ls -a";        #list hidden files
	};
	shellInit = lib.fileContents ./shell-init.sh;
  };
}
