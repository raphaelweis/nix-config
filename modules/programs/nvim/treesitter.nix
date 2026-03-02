{
  flake.modules.nixvimModules.treesitter = {
    plugins.treesitter = {
      enable = true;
      highlight.enable = true;
      indent.enable = true;
      folding.enable = true;
    };
  };
}
