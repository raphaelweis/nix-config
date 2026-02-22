{
  flake.modules.homeManager.git = {
    programs.git = {
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
  };
}
