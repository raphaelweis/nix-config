{
  flake.modules.nixos.ssh-server = {
    services.openssh = {
      enable = true;
      openFirewall = false;
      settings = {
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = false;
      };
    };

    users.users.root.openssh.authorizedKeys.keys = [
      # interstellar
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKWJs9kz11KDDuaj7nTyvAyadk0lrxG7fw5jypA2RXg4 raphael.weis.g@gmail.com"

      # john
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLa/udOZyWSUDAbd7y7hak5ucgYzquZ2HFvQwFcD558 raphael.weis.g@gmail.com"
    ];
  };
}
