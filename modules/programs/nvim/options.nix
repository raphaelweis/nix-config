{
  flake.modules.nixvimModules.options = {
    globals.mapleader = " ";
    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      clipboard = {
        providers.wl-copy.enable = true;
        register = "unnamedplus";
      };
      swapfile = false;
      signcolumn = "yes";
      winborder = "rounded";
      expandtab = true;
      undofile = true;
      colorcolumn = "80";
      foldenable = false;
    };
    diagnostic.settings = {
      virtual_text = true;
    };
  };
}
