-- powerlinish, I guess
local colors = {
	bg = "#121212",
	fg = "#ffffff",
	yellow = "#ffaf00",
	cyan = "#56b6c2",
	darkblue = "#2aa198",
	green = "#afdf00",
	orange = "#ff8700",
	violet = "#875fdf",
	magenta = "#d33682",
	blue = "#268bd2",
	red = "#df0000",
}

local vi_mode_utils = require("feline.providers.vi_mode")
local lsp = require("feline.providers.lsp")

local vi_mode_colors = {
	NORMAL = colors.green,
	INSERT = colors.blue,
	REPLACE = colors.violet,
	VISUAL = colors.magenta,
	COMMAND = colors.violet,
	TERM = colors.darkblue,
	NONE = colors.yellow,
}

local icons = {
	unix = " ",
	errs = " ",
	warns = " ",
	infos = " ",
	hints = " ",
	git = "",
	right_sep = "",
	left_sep = "",
}

local function file_osinfo()
	local os = vim.bo.fileformat:lower()
	return icons[os] .. os
end

local function diag_enable(f, s)
	return function()
		local diag = f()[s]
		return diag and diag ~= 0
	end
end

local function diag_of(f, s)
	local icon = icons[s]
	return function()
		local diag = f()[s]
		return icon .. diag
	end
end

local function vimode_hl()
	return { fg = colors.bg, bg = vi_mode_utils.get_mode_color() }
end

local function lsp_diagnostics_info()
	return {
		errs = lsp.get_diagnostics_count("Error"),
		warns = lsp.get_diagnostics_count("Warning"),
		infos = lsp.get_diagnostics_count("Information"),
		hints = lsp.get_diagnostics_count("Hint"),
	}
end

local vi_mode = {
	left = {
		provider = function()
			return " " .. vi_mode_utils.get_vim_mode() .. " "
		end,
		hl = vimode_hl,
		right_sep = icons.right_sep,
	},
	right = {
		provider = function()
			return string.format(" %d:%-d ", vim.fn.line("."), vim.fn.col("."))
		end,
		hl = vimode_hl,
		left_sep = icons.left_sep,
	},
}
local function_info = {
	provider = function()
		if not packer_plugins["nvim-treesitter"].loaded then
			return " "
		end
		local l = vim.fn["nvim_treesitter#statusline"]({ 90 })
		if l == nil or l == vim.NIL then
			return " "
		end
		return string.format(" %s ", l)
	end,
}

local components = { active = {}, inactive = {} }

local file = {
	encoding = {
		provider = "file_encoding",
		left_sep = " ",
		hl = { fg = colors.violet, style = "bold" },
	},
	info = { provider = "file_info", hl = { fg = colors.white, style = "bold" } },
	os = {
		provider = file_osinfo,
		left_sep = " ",
		hl = { fg = colors.violet, style = "bold" },
	},
	type = { provider = "file_type" },
}

local lsp_name = {

	provider = "lsp_client_names",
	left_sep = " ",
	icon = icons.lsp,
	hl = { fg = colors.yellow },
}

local diagnos = {
	err = {
		provider = "diagnostic_errors",
		left_sep = " ",
		hl = { fg = colors.red },
	},
	hint = {
		provider = "diagnostic_hints",
		left_sep = " ",
		hl = { fg = colors.cyan },
	},
	info = {
		provider = "diagnostic_info",
		left_sep = " ",
		hl = { fg = colors.blue },
	},
	warn = {
		provider = "diagnostic_warnings",
		left_sep = " ",
		hl = { fg = colors.yellow },
	},
}

local git = {
	add = { provider = "git_diff_added", hl = { fg = colors.green } },
	branch = {
		provider = "git_branch",
		icon = icons.git,
		left_sep = " ",
		hl = { fg = colors.violet, style = "bold" },
	},
	change = { provider = "git_diff_changed", hl = { fg = colors.orange } },
	remove = { provider = "git_diff_removed", hl = { fg = colors.red } },
}

local space = { provider = "  " }

local comp_left_active = {}
for _, c in pairs({
	vi_mode.left,
	space,
	file.readonly,
	file.info,
	lsp_name,
	space,
	diagnos.err,
	diagnos.warn,
	diagnos.hint,
	diagnos.info,
}) do
	table.insert(comp_left_active, c)
end

local comp_left_inactive = {}
for _, c in pairs({ vi_mode.left, space, file.info }) do
	table.insert(comp_left_inactive, c)
end

local comp_right_active = {}
for _, c in pairs({
	function_info,
	space,
	git.add,
	git.change,
	git.remove,
	file.os,
	git.branch,
	space,
	vi_mode.right,
}) do
	table.insert(comp_right_active, c)
end

-- Insert three sections (left, mid and right) for the active statusline
table.insert(components.active, comp_left_active)
table.insert(components.active, {})
table.insert(components.active, comp_right_active)

-- Insert two sections (left and right) for the inactive statusline
table.insert(components.inactive, comp_left_inactive)
table.insert(components.inactive, {})

local force_inactive = {
	filetypes = { "packer", "startify", "fugitive", "fugitiveblame" },
	buftypes = { "terminal" },
	bufnames = {},
}

require("feline").setup({
	bg = colors.bg,
	fg = colors.fg,
	components = components,
	properties = properties,
	vi_mode_colors = vi_mode_colors,
})
