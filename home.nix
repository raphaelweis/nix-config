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
    neovim
    vscode
    spotify
    discord
  ];
  
  programs.zsh = {
    oh-my-zsh = {
      enable = true;
      plugins = [ "powerlevel10k" ];
    };
  };

  home.stateVersion = "22.11";
}
