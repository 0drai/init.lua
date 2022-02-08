local M = {}
local g = vim.g
local o = vim.opt_local
local u = require("config.utils")

local cache = os.getenv("XDG_CACHE_HOME")

M.gutentags = function()
	local tags_dir = string.format("%s/tags", cache)

	if io.open(tags_dir, "r") == nil then
		os.execute(string.format("mkdir -p %s", tags_dir))
		print("created gutentags dir @ %s", tags_dir)
	end

  -- NOTE: telescope does only look for local tag files,
	-- which sucks big time
	-- https://github.com/nvim-telescope/telescope.nvim/pull/288
	g.gutentags_cache_dir = tags_dir
	g.gutentags_ctags_extra_args = { "-R" }
end

M.indent_bline = function()
	g.indent_blankline_show_current_context = true
	g.indent_blankline_show_first_indent_level = false
	g.indent_blankline_use_treesitter = true
	g.indent_blankline_filetype_exclude = { "dashboard", "telescope" }
end

M.rooter = function()
	g.rooter_silent_chdir = 1
	g.rooter_patterns = {
		".git",
		"Makefile",
		".vim",
		"compile_commands.json",
		"CMakeLists.txt",
		".node_modules",
		"package.json",
		"Cargo.toml",
	}
end

M.matchup = function()
	-- matchup makes cursor movement laggy on older machines,
	-- these options help somewhat
	-- https://github.com/andymass/vim-matchup#deferred-highlighting
	g.matchup_matchparen_deferred = 1
	g.matchup_matchparen_deferred_show_delay = 200
	g.matchup_surround_enabled = 1
end

M.zen = function()
	require("zen-mode").setup({
		plugins = { gitsigns = false, tmux = true },

		-- NOTE: https://github.com/folke/zen-mode.nvim/issues/26
		on_open = function()
			o.number = false
			o.relativenumber = false
			vim.cmd([[IndentBlanklineDisable]])
		end,
		on_close = function()
			o.number = true
			o.relativenumber = true
			vim.cmd([[IndentBlanklineEnable]])
		end,
	})
end

M.vimwiki = function()
	local wiki = os.getenv("WIKI")
	u.command("VimwikiScratch", string.format("e %s/Scratchpad.md", wiki))

	g.vimwiki_auto_header = 1
	g.vimwiki_hl_headers = 1
	g.vimwiki_markdown_link_ext = 1
	g.vimwiki_list = {
		{
			["path"] = wiki,
			["syntax"] = "markdown",
			["ext"] = ".md",
			["auto_generate_tags"] = 1,
			["auto_generated_links"] = 1,
		},
	}
	g.taskwiki_markup_syntax = "markdown"
	g.taskwiki_taskrc_location = os.getenv("TASKRC")
	g.taskwiki_data_location = os.getenv("TASKDATA")

	g.vimwiki_conceallevel = 0
end

return M
