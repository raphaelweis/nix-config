{
  flake.modules.homeManager.nvim =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ripgrep
        tree-sitter
        websocat

        # LSPs
        nixd
        clang-tools
        typescript-language-server
        vscode-langservers-extracted
        prisma-language-server
        prettier
        kdePackages.qtdeclarative
        tinymist

        # Formatters
        nixfmt
        stylua
        clang-tools
        shfmt
      ];
      programs.neovim = {
        enable = true;
        defaultEditor = false;
        vimAlias = true;
        withNodeJs = false;
        withPython3 = false;
        withRuby = false;
        plugins = with pkgs.vimPlugins; [
          vim-tmux-navigator
          nvim-treesitter.withAllGrammars
          cmp-nvim-lsp
          cmp-buffer
          cmp-path
          lspkind-nvim
          cmp_luasnip
          plenary-nvim
          friendly-snippets
          {
            plugin = gitsigns-nvim;
            type = "lua";
            config = # lua
              ''
                require("gitsigns").setup()
              '';
          }
          {
            plugin = nvim-autopairs;
            type = "lua";
            config = # lua
              ''
                require("nvim-autopairs").setup()
              '';
          }
          {
            plugin = typst-preview-nvim;
            type = "lua";
            config = # lua
              ''
                require("typst-preview").setup({
                	port = 8000,
                	dependencies_bin = {
                		["tinymist"] = nil,
                		["websocat"] = nil,
                	},
                })
              '';
          }
          {
            plugin = gruvbox-nvim;
            type = "lua";
            config = # lua
              ''
                require("gruvbox").setup({
                	contrast = "hard",
                	italic = { strings = false },
                	overrides = {
                		SignColumn = { bg = "NONE" },
                	},
                })
                vim.cmd("colorscheme gruvbox")
              '';
          }
          {
            plugin = nvim-web-devicons;
            type = "lua";
            config = # lua
              ''
                require("nvim-web-devicons").setup()
              '';
          }
          {
            plugin = telescope-nvim;
            type = "lua";
            config = # lua
              ''
                local builtin = require("telescope.builtin")
                vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
                vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
              '';
          }
          {
            plugin = telescope-fzf-native-nvim;
            type = "lua";
            config = # lua
              ''
                require("telescope").load_extension("fzf")
              '';
          }
          {
            plugin = nvim-treesitter;
            type = "lua";
            config = # lua
              ''
                vim.api.nvim_create_autocmd("FileType", {
                	pattern = {
                		"bash",
                		"c",
                		"cpp",
                		"css",
                		"diff",
                		"dockerfile",
                		"gitcommit",
                		"gitignore",
                		"html",
                		"java",
                		"javascript",
                		"json",
                		"lua",
                		"markdown",
                		"nix",
                		"python",
                		"sql",
                		"typescript",
                		"tsx",
                		"vim",
                		"xml",
                		"yaml",
                		"zsh",
                		"typst",
                	},
                	callback = function()
                		vim.treesitter.start()
                	end,
                })
              '';
          }
          {
            plugin = vim-fugitive;
            type = "lua";
            config = # lua
              ''
                vim.keymap.set("n", "<leader>;", "<CMD>tab Git<CR>", { desc = "Open Fugitive in a new tab" })
              '';
          }
          {
            plugin = oil-nvim;
            type = "lua";
            config = # lua
              ''
                require("oil").setup()
                vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>")
              '';
          }
          {
            plugin = nvim-cmp;
            type = "lua";
            config = # lua
              ''
                local cmp = require("cmp")
                local lspkind = require("lspkind")
                cmp.setup({
                	sources = {
                		{ name = "nvim_lsp" },
                		{ name = "buffer" },
                		{ name = "path" },
                		{ name = "luasnip" },
                	},
                	window = {
                		completion = cmp.config.window.bordered(),
                		documentation = cmp.config.window.bordered(),
                	},
                	completion = {
                		completeopt = "menu,menuone,noinsert",
                	},
                	formatting = {
                		fields = { "menu", "abbr", "kind" },
                		format = lspkind.cmp_format({
                			mode = "symbol_text",
                			menu = {
                				buffer = "[BFR]",
                				nvim_lsp = "[LSP]",
                				luasnip = "[SNP]",
                				path = "[PTH]",
                			},
                		}),
                		snippet = {
                			expand = function(args)
                				require("luasnip").lsp_expand(args.body)
                			end,
                		},
                	},
                	mapping = cmp.mapping.preset.insert({
                		["<C-n>"] = cmp.mapping.select_next_item(),
                		["<C-p>"] = cmp.mapping.select_prev_item(),
                		["<C-y>"] = cmp.mapping.confirm({ select = true }),
                		["<C-space>"] = cmp.mapping.complete({}),
                		["<C-l>"] = cmp.mapping(function()
                			if luasnip.expand_or_locally_jumpable() then
                				luasnip.expand_or_jump()
                			end
                		end, { "i", "s" }),
                		["<C-h>"] = cmp.mapping(function()
                			if luasnip.locally_jumpable(-1) then
                				luasnip.jump(-1)
                			end
                		end, { "i", "s" }),
                	}),
                })

                local capabilities = require("cmp_nvim_lsp").default_capabilities()
                vim.lsp.config("*", {
                	capabilities = capabilities,
                })
              '';
          }
          {
            plugin = nvim-lspconfig;
            type = "lua";
            config = # lua
              ''
                vim.lsp.enable("nixd")
                vim.lsp.enable("clangd")
                vim.lsp.enable("ts_ls")
                vim.lsp.enable("eslint")
                vim.lsp.enable("css")
                vim.lsp.enable("html")
                vim.lsp.enable("json")
                vim.lsp.enable("markdown")
                vim.lsp.enable("prismals")
                vim.lsp.enable("qmlls")
              '';
          }
          {
            plugin = conform-nvim;
            type = "lua";
            config = # lua
              ''
                require("conform").setup({
                	formatters_by_ft = {
                		nix = { "nixfmt", "injected" },
                		c = { "clang-format" },
                		lua = { "stylua" },
                		sh = { "shfmt" },
                		javascript = { "prettier" },
                		typescript = { "prettier" },
                		json = { "prettier" },
                		css = { "prettier" },
                		html = { "prettier" },
                		markdown = { "prettier" },
                	},
                	formatters = {
                		injected = {
                			options = {
                				lang_to_ft = {
                					lua = "lua",
                					bash = "sh",
                				},
                			},
                		},
                	},
                	default_format_opts = {
                		lsp_format = "fallback",
                	},
                })
                vim.keymap.set("n", "<leader>fm", require("conform").format, { desc = "Format current file" })
              '';
          }
          {
            plugin = luasnip;
            type = "lua";
            config = # lua
              ''
                require("luasnip.loaders.from_vscode").lazy_load()
              '';
          }
        ];
        initLua = # lua
          ''
            vim.g.mapleader = " "
            vim.opt.number = true
            vim.opt.relativenumber = true
            vim.opt.tabstop = 2
            vim.opt.shiftwidth = 2
            vim.opt.clipboard:append("unnamedplus")
            vim.opt.swapfile = false
            vim.opt.signcolumn = "yes"
            vim.opt.winborder = "rounded"
            vim.opt.expandtab = true
            vim.opt.undofile = true
            vim.opt.colorcolumn = "80"

            vim.diagnostic.config({ virtual_text = true })

            vim.keymap.set("n", "<ESC>", "<CMD>noh<CR>", { desc = "Remove highlight after search" })
            vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Go up 1 screen line" })
            vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Go down 1 screen line" })

            vim.keymap.set("n", "td", function()
            	local new_config = not vim.diagnostic.config().virtual_lines
            	vim.diagnostic.config({
            		virtual_lines = not vim.diagnostic.config().virtual_lines,
            		virtual_text = not vim.diagnostic.config().virtual_text,
            	})
            end, { desc = "Toggle diagnostic virtual lines" })
          '';
      };
    };
}
