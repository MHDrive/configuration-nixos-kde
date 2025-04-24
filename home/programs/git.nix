{ pkgs, ... }:

{
  programs.git = {
	enable = true;
	userName = "Muhammad Hamdi";
	userEmail = "hamdj360@gmail.com";
	aliases = {
		ci = "commit";
		co = "checkout";
		s = "status";
	};
  };
}
