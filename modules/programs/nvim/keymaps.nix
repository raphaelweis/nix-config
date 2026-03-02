{
  flake.modules.nixvimModules.keymaps = {
    keymaps = [
      {
        key = "<ESC>";
        action = "<CMD>noh<CR>";
      }
      {
        key = "j";
        action = "v:count == 0 ? 'gj' : 'j'";
        options = {
          expr = true;
          silent = true;
        };
      }
      {
        key = "k";
        action = "v:count == 0 ? 'gk' : 'k'";
        options = {
          expr = true;
          silent = true;
        };
      }
    ];
  };
}
