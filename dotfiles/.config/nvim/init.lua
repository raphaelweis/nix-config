-- Options
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.undofile = true
vim.opt.colorcolumn = "80"
vim.opt.foldenable = false
vim.opt.showmode = false
vim.opt.clipboard:append("unnamedplus")

-- Keymaps
vim.keymap.set("n", "<ESC>", "<CMD>noh<CR>")

-- Pack
local hooks = {
	["telescope-fzf-native.nvim"] = function(ev)
		vim.system({ "make" }, { cwd = ev.data.path }):wait()
	end,
	["nvim-treesitter"] = function(ev)
		if not ev.data.active then
			vim.cmd.packadd("nvim-treesitter")
		end
		vim.cmd("TSUpdate")
	end,
}
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if kind == "install" or kind == "update" then
			local hook = hooks[name]
			if hook then
				vim.schedule(function()
					local ok, err = pcall(hook, ev)
					if not ok then
						vim.notify("Build hook failed for " .. name .. ":\n" .. tostring(err), vim.log.levels.ERROR)
					else
						vim.notify("Build hook completed for " .. name, vim.log.levels.INFO)
					end
				end)
			end
		end
	end,
})
vim.pack.add({
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/tpope/vim-fugitive",
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("*") },
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
})

-- Colorscheme setup
require("gruvbox").setup({
	italic = {
		strings = false,
		emphasis = false,
		comments = false,
		operators = false,
		folds = false,
	},
	contrast = "hard",
})
vim.cmd("colorscheme gruvbox")

-- Telescope
local telescope = require("telescope")
telescope.setup({
	pickers = {
		find_files = {
			file_ignore_patterns = { "node_modules", ".git", ".venv" },
			hidden = true,
		},
	},
})
telescope.load_extension("fzf")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })

-- Autopairs
require("nvim-autopairs").setup()

--Conform
local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		json = { "prettierd" },
		html = { "prettierd" },
		css = { "prettierd" },
		markdown = { "prettierd" },
		nix = { "nixfmt" },
	},
})
vim.keymap.set({ "n", "v" }, "<leader>fm", conform.format)

-- Blink.cmp
require("blink.cmp").setup({
	completion = { documentation = { auto_show = true } },
	sources = {
		default = { "lsp", "path", "buffer" },
	},
})

-- LSP
vim.lsp.enable({
	"lua_ls",
	"nixd",
	"vtsls",
	"eslint",
	"cssls",
	"html",
	"pyright",
})

vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- '${3rd}/luv/library',
					-- '${3rd}/busted/library',
				},
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

-- Treesitter
require("nvim-treesitter").install({
	"lua",
	"nix",
	"markdown",
	"markdown_inline",
	"typescript",
	"javascript",
	"python",
})

-- Oil
require("oil").setup({
	view_options = {
		show_hidden = true,
	},
})
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>")

-- Gitsigns
require("gitsigns").setup()

-- Fugitive
vim.keymap.set("n", "<leader>;", "<CMD>Git<CR>")

-- Lualine
require("lualine").setup()
