{ self, ... }:
{
  flake.modules.nixos.server = {
    imports = with self.modules.nixos; [
      disko-server
      boot-server
      networking-server
      ssh-server
      fail2ban-server
    ];
  };
}
