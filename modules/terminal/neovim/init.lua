----------------------------
-- Keymaps --
----------------------------

vim.g.mapleader = " " -- define space as leader key

-- general keymaps
vim.keymap.set("i", "jk", "<ESC>") -- use jk to exit insert mode

-- plugin specific keymaps

-----------------------------
-- Options --
-----------------------------

-- appearance
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers wrapping cursor line (10 lines)
vim.opt.termguicolors = true -- enable 24-bit RGB color for the UI
vim.opt.background = "dark" -- choose preferred option for the colorscheme (light/dark)
vim.opt.signcolumn = "auto" -- draws a column on the left to display things like breakpoints (auto = only when necessary)

-- text editing
vim.opt.tabstop = 2 -- tabs = 2 spaces
vim.opt.shiftwidth = 2 -- indentation = 2 spaces
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.autoindent = true -- copy indent from current line when going to a new line
vim.opt.wrap = false -- lines that are too long will not show on the line under them
vim.opt.formatoptions:remove({ "c", "r", "o"}) -- prevent nvim from interfering with comments

-----------------------------
-- Color Scheme --
-----------------------------

-- configuration function for the 
local colorschemeConfig = function() -- configuration for gruvbox.nvim plugin (main colorscheme)
  require("gruvbox").setup({
    italic = false,
    transparent_mode = true, -- set to true for a grey background
  })
  vim.cmd("colorscheme gruvbox") -- set colorscheme
end

-----------------------------
-- Plugins declaration
-----------------------------

-- installation for the lazy.nvim plugin manager (pulled straight from the documentation)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugins table :
local plugins = {
  {
    "ellisonleao/gruvbox.nvim", -- colorscheme plugin (currently main colorscheme)
    lazy = false,
    priority = 1000,
    config = colorschemeConfig,
  },
}

-- options table :
local opts = {}

-- installation :
require("lazy").setup(plugins, opts)

-----------------------------
-- Plugins configuration
-----------------------------
