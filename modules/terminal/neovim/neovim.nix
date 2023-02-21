{ pkgs, lib, ... }: 

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraLuaConfig = lib.fileContents ./nvim/init.lua;
  };
}