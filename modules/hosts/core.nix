{
  self,
  ...
}:
{
  flake.modules.nixos.core = {
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
    home-manager.sharedModules = [ self.modules.homeManager.core ];
  };

  flake.modules.homeManager.core = {
    imports = with self.modules.homeManager; [
      # cmdline
      cmdline-pkgs
      nvim
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

      # desktop
      fonts
      cursor
      xdg
    ];
  };
}
