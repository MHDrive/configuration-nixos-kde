{ pkgs, ... }:

{
  programs.zsh = {
	enable = true;
	enableCompletion = true;
	autosuggestion = {
		enable = true;
		highlight = "fg=#ff00ff,bg=cyan,bold,underline";
	};
	syntaxHighlighting = {
		enable = true;
	};
	history = {
		size = 10000;
	};
	shellAliases = {
		ll = "ls -l";
		".." = "cd ..";
		la = "ls -a";
		lla = "ls -la";
	};
  };
}
