{ lib, inputs, nixpkgs, home-manager, user }:

let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  lib = nixpkgs.lib;
in

{
  desktop = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user;
      host = {
        hostName = "desktop";
      };
    };
    modules = [
      ./desktop
      ./configuration.nix
      
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user pkgs;
          host = {
            hostName = "desktop";
          };
        };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./desktop/home.nix)];
        };
      }
    ];
  };

  laptop = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user;
      host = {
        hostName = "laptop";
      };
    };
    modules = [
      ./laptop
      ./configuration.nix
      
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user pkgs;
          host = {
            hostName = "laptop";
          };
        };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./laptop/home.nix)];
        };
      }
    ];
  };
}
