{ inputs, ... }:
{
  flake.modules.nixvimModules.diffs =
    { pkgs, ... }:
    let
      # this is an example of how to access a package in nixpkgs-unstable instead
      # of using nixvim's default nixpkgs channel
      pkgsUnstable = inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      extraPlugins = [ pkgsUnstable.vimPlugins.diffs-nvim ];
      globals = {
        diffs = {
          fugitive = true;
        };
      };
    };
}
