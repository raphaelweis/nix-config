{ inputs, ... }:
{

  flake.modules.nixos.flatpak = {
    imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
    services.flatpak = {
      enable = true;
      packages = [
        # pgadmin desktop with electron not available in nixpkgs so we are using the
        # flatpak for now. TODO: try to package pgadmin with electron
        "org.pgadmin.pgadmin4"
      ];
    };
  };
}
