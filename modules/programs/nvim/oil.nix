{
  flake.modules.nixvimModules.oil = {
    plugins.oil = {
      enable = true;
      settings = {
        keymaps = {
          "<C-l>" = false;
          "<C-h>" = false;
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<CMD>Oil<CR>";
      }
    ];
  };
}
