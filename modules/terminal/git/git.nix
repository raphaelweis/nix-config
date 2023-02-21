{ pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      userName = "Raphaël Weis";
      userEmail = "raphael.weis.2003@gmail.com";
      signing.key = "02A1BEA82DAED625";
    };
  };
}