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
            rev = "7a3c4ea01e2ad53c6b54136bc19b7f0ad977da7d";
            hash = "sha256-rsgboDQ7s9pIc+pDOJgwTA6c950CDY7gLsyn5oycsGI=";
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
