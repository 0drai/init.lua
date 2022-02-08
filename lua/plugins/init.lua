-- bootstrap packer
local fn = vim.fn

-- $XDG_DATA_HOME/nvim/..
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({
		"git",
		"clone",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.api.nvim_command("packadd packer.nvim")
end

local pack = require("packer")

pack.startup(function(use)
	-- packer manages itself
	use({ "wbthomason/packer.nvim", opt = true })

	-- classics
	use({ "tpope/vim-repeat", keys = { "." } })
	use({ "tpope/vim-surround" })
	use({ "tpope/vim-fugitive", cmd = { "Git", "Gwrite", "Gedit", "Gvdiffsplit" } })
	use({ "tpope/vim-commentary" })

	-- g<, g>, gs to swap stuff
	use({ "machakann/vim-swap" })

	-- align stuff
	use({ "godlygeek/tabular", cmd = "Tabularize" })

	-- move reliably to root folder
	use({
		"airblade/vim-rooter",
		config = function()
			require("plugins.others").rooter()
		end,
	})

	use({
		"lambdalisue/suda.vim",
		config = function()
			vim.g.suda_smart_edit = 1
		end,
	})

	-- LSP stuff
	-- does not need lazy loading, since it is already lazy
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("lsp")
		end,
		requires = {

			-- echodoc in good
			{ "ray-x/lsp_signature.nvim" },

			{ "tami5/lspsaga.nvim" },

			-- enhances rust
			{ "simrat39/rust-tools.nvim" },

			-- enhances C/C++
			{ "p00f/clangd_extensions.nvim" },
		},
	})

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "rafamadriz/friendly-snippets" },
			{ "L3MON4D3/LuaSnip" },

			-- icons in pum
			{

				"onsails/lspkind-nvim",
				config = function()
					require("lspkind").init({
						mode = "symbol",
					})
				end,
			},

			-- sources
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-emoji" },
			{ "hrsh7th/cmp-path" },
		},

		config = function()
			require("plugins.cmp")
		end,
		after = { "neogen" },
	})

	use({
		"abecodes/tabout.nvim",
		wants = "nvim-treesitter",
		after = "nvim-cmp",
		config = function()
			require("plugins.tabout")
		end,
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.null-ls")
		end,
	})

	-- FZF replacement with in-built LSP features
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("plugins.telescope")
		end,
		-- cmd = { 'Telescope' },
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-bibtex.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
	})

	use({
		"AckslD/nvim-neoclip.lua",
		requires = { "tami5/sqlite.lua", module = "sqlite" },
		config = function()
			require("neoclip").setup({ enable_persistent_history = true })
		end,
	})

	use({
		"marko-cerovac/material.nvim",
		config = function()
			require("plugins.material")
		end,
	})

	use({
		"lukas-reineke/indent-blankline.nvim",
		wants = "nvim-treesitter",
		config = function()
			require("plugins.others").indent_bline()
		end,
	})

	-- lua statusline
	use({
		"famiu/feline.nvim",
		event = "BufWinEnter",
		config = "require('plugins.feline')",
		wants = "gitsigns.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})

	-- gitgutter replacement
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = "require('plugins.gitsigns')",
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		-- event = "CursorHold",
		config = "require('plugins.treesitter')",
		requires = { "nvim-treesitter/nvim-treesitter-textobjects" },
		run = ":TSUpdate",
	})

	use({
		"p00f/nvim-ts-rainbow",
		event = "CursorMoved",
		after = "nvim-treesitter",
	})

	-- treesitter powered matchup
	-- e.g., detects switch statements blocks and so on
	use({
		"andymass/vim-matchup",
		after = "nvim-treesitter",
		event = "CursorMoved",
		config = function()
			require("plugins.others").matchup()
		end,
	})

	use({
		"windwp/nvim-autopairs",
		after = "nvim-treesitter",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
				fast_wrap = {},
			})
		end,
	})

	use({
		"danymat/neogen",
		after = "nvim-treesitter",
		config = function()
			require("neogen").setup({
				enabled = true,
				jump_key = "<TAB>",
			})
		end,
	})

	use({
		"vimwiki/vimwiki",
		requires = { "ElPiloto/telescope-vimwiki.nvim", "tools-life/taskwiki", "mattn/calendar-vim" },
		config = function()
			require("plugins.others").vimwiki()
		end,
	})

	-- goyo replacement
	use({
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		requires = { "folke/twilight.nvim", cmd = "ZenMode" },
		config = function()
			require("plugins.others").zen()
		end,
	})

	-- ,v for outline of document
	use({ "simrat39/symbols-outline.nvim", opt = true, cmd = { "SymbolsOutline" } })

	-- tiling(?) panes for vim
	use({
		"beauwilliams/focus.nvim",
		config = function()
			require("focus").setup({
				number = true,
				relativenumber = true,
				hybridnumber = true,
				cursorline = true,
			})
		end,
	})

	use({
		"glepnir/dashboard-nvim",
		event = "BufWinEnter",
		config = function()
			require("plugins.dashboard")
		end,
	})

	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
		ft = { "markdown", "md" },
	})
	use({ "https://github.com/plasticboy/vim-markdown", ft = { "markdown", "md" } })
	use({ "ron89/thesaurus_query.vim", cmd = "ThesaurusQueryReplaceCurrentWord" })
	use({ "lervag/vimtex", ft = { "latex", "tex" } })
end)
