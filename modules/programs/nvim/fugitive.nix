{
  flake.modules.nixvimModules.fugitive = {
    plugins.fugitive.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>;";
        action = "<CMD>Git<CR>";
      }
    ];
  };
}
