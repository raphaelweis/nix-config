{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "server";

  flake.modules.nixos.server = {
    networking.hostName = "nanorion";

    imports = with self.modules.nixos; [ server ];

    system.stateVersion = "25.05";
  };
}
