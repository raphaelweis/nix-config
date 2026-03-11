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
      };
    };
    plugins.bufferline.settings.highlights = {
      tab_selected = {
        fg = {
          attribute = "fg";
          highlight = "GruvboxYellowBold";
        };
        bold = true;
      };
    };
  };
}
