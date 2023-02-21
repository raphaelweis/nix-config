{ config, pkgs, lib, user, ... }:

{

  imports =
    (import ../modules/shell) ++
    (import ../modules/terminal);

  programs.home-manager.enable = true;
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
      vscode
      spotify
      discord
      keepassxc
      thunderbird
      gnupg
      pinentry
    ];
  };

  services = {
    dropbox.enable = true;
  };

  home.stateVersion = "22.11";
}
