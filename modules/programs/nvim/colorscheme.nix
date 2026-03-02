{
  flake.modules.nixvimModules.colorscheme = {
    colorscheme = "gruvbox";
    colorschemes.gruvbox = {
      enable = true;
      settings = {
        contrast = "hard";
        italic = {
          strings = false;
        };
        overrides = {
          SignColumn = {
            bg = "NONE";
          };
        };
      };
    };
  };
}
