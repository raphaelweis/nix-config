{ config, pkgs, lib, ... }:

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
    enable = true;
    shellAliases = {
      la = "ls -la";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
      ];
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    initExtraBeforeCompInit = ''
      source ~/.p10k.zsh
    '';
  };

  home.stateVersion = "22.11";
}
