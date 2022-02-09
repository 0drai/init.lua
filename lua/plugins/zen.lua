local o = vim.opt_local

	require("zen-mode").setup({
		plugins = { gitsigns = false, tmux = true },

		-- NOTE: https://github.com/folke/zen-mode.nvim/issues/26
		on_open = function()
			o.number = false
			o.relativenumber = false
			o.signcolumn = "no"
			vim.diagnostic.config({ virtual_text = false })
			vim.cmd([[IndentBlanklineDisable]])
		end,
		on_close = function()
			o.number = true
			o.relativenumber = true
			o.signcolumn = "auto:2"
			vim.diagnostic.config({
				virtual_text = { source = "always", prefix = "●" },
				float = { source = "always" },
				underline = true,
			})
			vim.cmd([[IndentBlanklineEnable]])
		end,
	})
