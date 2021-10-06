require("gitsigns").setup({
	signs = {
		add = {
			hl = "GitSignsAdd",
			text = "│",
			numhl = "GitSignsAddNr",
			linehl = "GitSignsAddLn",
		},
		change = {
			hl = "GitSignsChange",
			text = "│",
			numhl = "GitSignsChangeNr",
			linehl = "GitSignsChangeLn",
		},
		delete = {
			hl = "GitSignsDelete",
			text = "_",
			numhl = "GitSignsDeleteNr",
			linehl = "GitSignsDeleteLn",
		},
		topdelete = {
			hl = "GitSignsDelete",
			text = "‾",
			numhl = "GitSignsDeleteNr",
			linehl = "GitSignsDeleteLn",
		},
		changedelete = {
			hl = "GitSignsChange",
			text = "~",
			numhl = "GitSignsChangeNr",
			linehl = "GitSignsChangeLn",
		},
	},
	keymaps = {
		-- Default keymap options
		noremap = true,
		buffer = true,

		["n ]g"] = {
			expr = true,
			"&diff ? ']g' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'",
		},
		["n [g"] = {
			expr = true,
			"&diff ? '[g' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'",
		},

		["n <localleader>ga"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
		["v <localleader>ga"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
		["n <localleader>gu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
		["n <localleader>gr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
		["v <localleader>gr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
		["n <localleader>gR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
		["n <localleader>gp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
		["n <localleader>gb"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

		-- Text objects
		["o ig"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
		["x ig"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
	},
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = true, -- Toggle with `:Gitsigns toggle_word_diff`

	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
	},
	diff_opts = {
		internal = true,
	},
	current_line_blame_formatter_opts = { relative_time = false },
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000,
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
})
