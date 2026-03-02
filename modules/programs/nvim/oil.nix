{
  flake.modules.nixvimModules.oil = {
    plugins.oil.enable = true;
    keymaps = [
      {
        key = "<leader>e";
        action = "<CMD>Oil<CR>";
      }
    ];
  };
}
