{
  inputs,
  self,
  ...
}:
let
  hostname = "nanorion";
in
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" hostname;

  flake.modules.nixos.${hostname} = {
    networking.hostName = hostname;

    imports = with self.modules.nixos; [
      server
      ./_hardware-configuration.nix
    ];

    system.stateVersion = "25.11";
  };
}
