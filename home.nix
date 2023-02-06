{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  home = {
    username = "raphaelw";
    homeDirectory = "/home/raphaelw";
  };

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    alacritty
    vscode
    spotify
    discord
  ];

  home.stateVersion = "22.11";
}