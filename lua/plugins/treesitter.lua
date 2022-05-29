require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"cpp",
		"lua",
		"json",
		"yaml",
		"python",
		-- "latex", -- not really stable
		"bash",
		"html",
		"typescript",
		"javascript",
		"cmake",
		"bibtex",
		"dockerfile",
		"rust",
    "markdown",
		"comment",
		"toml",
	},

	highlight = {
		enable = true,
	},

	textobjects = {
		select = {
			enable = true,
			lookeahead = true,
			keymaps = {
				["ac"] = "@comment.outer",
				["ic"] = "@class.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
			},
		},
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = ".",
			scope_incremental = ";",
			node_decremental = "-",
		},
	},

	move = {
		enable = true,
		set_jumps = true, -- whether to set jumps in the jumplist
		goto_next_start = {
			["]m"] = "@function.outer",
			["]]"] = "@class.outer",
		},
		goto_next_end = {
			["]M"] = "@function.outer",
			["]["] = "@class.outer",
		},
		goto_previous_start = {
			["[m"] = "@function.outer",
			["[["] = "@class.outer",
		},
		goto_previous_end = {
			["[M"] = "@function.outer",
			["[]"] = "@class.outer",
		},
	},

	rainbow = {
		enable = true,
		extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
		max_file_lines = 200,
	},

	matchup = {
		enable = true, -- mandatory, false will disable the whole extension
	},

	autopairs = { enable = true },
	indent = { enable = true, disable = { "python" } },
})
