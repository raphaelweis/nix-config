{ config, pkgs, lib, user, ... }:

{

  imports =
    (import ../modules/shell);

  programs.home-manager.enable = true;
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
      alacritty
      neovim
      vscode
      spotify
      discord
      keepassxc
    ];
  };

  # programs = {
  #   zsh = {
  #     enable = true;
  #     shellAliases = {
  #       la = "ls -la";
  #     };
  #     zplug = {
  #       enable = true;
  #       plugins = [
  #         { name = "zsh-users/zsh-autosuggestions"; }
  #         { name = "zsh-users/zsh-syntax-highlighting"; tags = [ defer:2 ]; }
  #       ];
  #     };
  #     plugins = [
  #       {
  #         name = "powerlevel10k";
  #         src = pkgs.zsh-powerlevel10k;
  #         file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  #       }
  #     ];
  #     initExtraBeforeCompInit = ''
  #       source ~/.p10k.zsh
  #     '';
  #   };
  # };
  
  services = {
    dropbox.enable = true;
  };

  home.stateVersion = "22.11";
}
