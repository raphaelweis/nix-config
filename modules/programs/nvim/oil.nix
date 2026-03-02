{
  flake.modules.nixvimModules.oil = {
    plugins.oil.enable = true;
    keymaps = [
      {
        key = "<leader>e";
        mode = "n";
        action = "<CMD>Oil<CR>";
      }
    ];
  };
}
