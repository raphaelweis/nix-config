{
  flake.modules.nixvimModules.options =
    { pkgs, ... }:
    {
      globals.mapleader = " ";
      clipboard = {
        register = "unnamedplus";
        providers.wl-copy.enable = pkgs.stdenv.hostPlatform.isLinux;
      };
      opts = {
        number = true;
        relativenumber = true;
        tabstop = 2;
        shiftwidth = 2;
        swapfile = false;
        signcolumn = "yes";
        winborder = "rounded";
        expandtab = true;
        undofile = true;
        colorcolumn = "80";
        foldenable = false;
        showmode = false;
      };
      diagnostic.settings = {
        virtual_text = true;
      };
    };
}
