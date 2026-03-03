{
  flake.modules.nixvimModules.oil = {
    plugins.oil.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<CMD>Oil<CR>";
      }
    ];
  };
}
