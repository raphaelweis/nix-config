{ inputs, ... }:
{
  flake.modules.nixos.sops = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    sops = {
      secrets = {
        wireguard_private_key = {
          mode = "0400";
        };
      };
    };
  };
}
