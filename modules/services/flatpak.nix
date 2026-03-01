{ inputs, ... }:
{

  flake.modules.nixos.flatpak = {
    imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
    services.flatpak = {
      enable = true;
      overrides = {
        global = {
          Context.filesystems = [
            "/nix/store:ro"
          ];
        };
      };
      packages = [
        # pgadmin desktop with electron not available in nixpkgs so we are using the
        # flatpak for now. TODO: try to package pgadmin with electron
        "org.pgadmin.pgadmin4"

        # Discord nix package has issues with krisp audio so we use the flatpak instead
        "com.discordapp.Discord"
      ];
    };
  };
}
