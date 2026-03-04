{ inputs, ... }:
{
  flake.modules.nixos.sops = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    sops = {
      # These are shared secrets that need to be available accross all hosts.
      # For secrets that only apply to a specific host type of even a specific host,
      # see specific features (ex: Nextcloud)
      secrets = {
        wireguard_private_key = {
          mode = "0400";
        };
      };
    };
  };
}
