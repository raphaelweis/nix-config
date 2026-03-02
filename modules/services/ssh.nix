{
  flake.modules.nixos.ssh-server = {
    services.openssh.enable = true;

    users.users.root.openssh.authorizedKeys.keys = [
      # Laptop
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKWJs9kz11KDDuaj7nTyvAyadk0lrxG7fw5jypA2RXg4 raphael.weis.g@gmail.com"
    ];
  };
}
