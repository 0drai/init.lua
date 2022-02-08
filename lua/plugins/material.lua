vim.g.material_style = "darker"

require("material").setup({
	contrast = {
		sidebars = false,
		floating_windows = false,
		line_numbers = false,
		sign_column = false,
		cursor_line = false,
		non_current_windows = false,
		popup_menu = false,
	},
	italics = {
		comments = true,
		strings = true,
		keywords = true,
		functions = true,
		variables = false,
	},
	high_visibility = {
		lighter = false,
		darker = false,
	},
	disable = {
		borders = false,
		background = true,
		term_colors = true,
		eob_lines = false,
	},
	custom_highlights = {},
})

vim.cmd([[colorscheme material]])
