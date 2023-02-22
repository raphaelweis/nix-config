{ pkgs, lib, ... }: 

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = lib.fileContents ./init.lua;
  };
}