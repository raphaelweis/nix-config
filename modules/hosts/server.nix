{ self, ... }:
{
  flake.modules.nixos.server = {
    imports = with self.modules.nixos; [
      nix
      sops
      disko-server
      boot-server
      networking-constants
      networking-server
      ssh-server
      fail2ban-server
      nextcloud-server
    ];

    # Override generic nix module settings with server specific settings
    nixpkgs.config.allowUnfree = false;
  };
}
