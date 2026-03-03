{ inputs, ... }:
{
  flake.modules.nixos.sops-server = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    sops = {
      defaultSopsFile = ../.secrets.yaml;
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

      secrets = {
        example_key = { };
      };
    };
  };
}
