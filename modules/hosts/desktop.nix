{
  self,
  ...
}:
{
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [
      # system
      boot
      user
      locale
      bluetooth
      security
      nix-ld
      qt
      nix
      cmdline-pkgs
      networking
      flatpak
      docker

      # desktop
      gnome

      # misc
      home-manager
    ];
    home-manager.sharedModules = [ self.modules.homeManager.desktop ];
  };

  flake.modules.homeManager.desktop = {
    imports = with self.modules.homeManager; [
      # cmdline
      cmdline-pkgs
      tmux
      fzf
      gh
      git
      zsh
      opencode

      # gui
      gui-pkgs
      vscode
      zen
      ghostty
      spotify

      # desktop
      fonts
      cursor
      xdg
    ];
  };
}
