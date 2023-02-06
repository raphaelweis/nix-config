{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      user = "raphaelw";
    in {
      nixosConfigurations = {
        basicConfig = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };
      homeManagerConfig = {
        userConfig = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          username = "${user}";
          homeDirectory = "/home/${user}";
          configuration = {
            imports = [
              ./home.nix
            ];
          };
        };
      };
    };
}
