{
  flake.modules.nixos.networking = {
    networking = {
      networkmanager.enable = true;
    };
  };

  flake.modules.nixos.networking-server = {
    networking.firewall.allowedTCPPorts = [ 22 ];
  };
}
