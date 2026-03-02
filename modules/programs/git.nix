{
  flake.modules.homeManager.git = {
    # Use git, with lazygit as a TUI and delta as a diff viewer
    programs = {
      git = {
        enable = true;
        settings = {
          user = {
            email = "raphael.weis.g@gmail.com";
            name = "Raphaël Weis";
          };
          pull.rebase = true;
          push.autoSetupRemote = true;
        };
      };
      lazygit = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          git.pagers = [
            { pager = "delta --dark --paging=never"; }
          ];
        };
      };
      delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          syntax-theme = "gruvbox-dark";
        };
      };
    };
  };
}
