{
  flake.modules.homeManager.git = {
    # Use git and delta as a diff viewer
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
