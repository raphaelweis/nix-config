{
  flake.modules.nixvimModules.diffs =
    { pkgs, ... }:
    {
      extraPlugins = [
        # TODO try to package in nixpkgs
        (pkgs.vimUtils.buildVimPlugin {
          name = "diffs.nvim";
          src = pkgs.fetchFromGitHub {
            owner = "barrettruth";
            repo = "diffs.nvim";
            rev = "749a21ae3c5c1f419120765357fdcce29374f24a";
            hash = "sha256-BQfvqZX4DD1TcwHea6HxDOTPm2H+6JdaWlqCmgGorD0=";
          };
        })
      ];
      globals = {
        diffs = {
          fugitive = true;
        };
      };
    };
}
