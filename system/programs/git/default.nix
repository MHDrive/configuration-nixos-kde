{ config, lib, ...}:

{
  programs.git = {
    enable = true;
	config = {
	  user.name = "MHDrive";
	  user.email = "hamdj360@gmail.com";	  
	};
  };
}
