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
      networking-shared
      networking
      flatpak
      docker

      # desktop
      gnome
      steam

      # programs
      zsh
      vscode
      zen
      spotify
      excalidraw

      # desktop environment
      fonts
      cursor
      xdg

      # misc
      sops
      nextcloud
    ];
  };
}
