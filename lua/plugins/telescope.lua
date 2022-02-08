local actions = require("telescope.actions")
local u = require("config.utils")

require("telescope").setup({
	defaults = {
		selection_strategy = "reset",
		color_devicons = true,

		file_sorter = require("telescope.sorters").get_fzy_sorter,
		generic_sorter = require("telescope.sorters").get_fzy_sorter,

		file_ignore_patterns = { "%.pdf" },

		-- see https://github.com/ibhagwan/nvim-lua/blob/main/lua/plugin/telescope/init.lua#L32
		layout_strategy = "flex",
		layout_config = {
			width = 0.95,
			height = 0.85,

			horizontal = {
				width = 0.9,
				preview_cutoff = 60,
				preview_width = function(_, cols, _)
					if cols > 200 then
						return math.floor(cols * 0.7)
					else
						return math.floor(cols * 0.6)
					end
				end,
			},
			vertical = {
				width = 0.75,
				height = 0.85,
				preview_height = 0.4,
				mirror = true,
			},
			flex = {
				-- change to horizontal after 120 cols
				flip_columns = 120,
			},
		},

		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-b>"] = actions.preview_scrolling_up,
				["<C-f>"] = actions.preview_scrolling_down,
				["<C-c>"] = actions.close,
			},
			n = {
				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["<C-b>"] = actions.preview_scrolling_up,
				["<C-f>"] = actions.preview_scrolling_down,
				["<C-c>"] = actions.close,
				["<Esc>"] = false,
			},
		},
	},

	extensions = {

		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "ignore_case", -- or "ignore_case" or "respect_case"
		},

		bibtex = {
			depth = 1,
			global_files = { os.getenv("MASTERBIB") },
			search_keys = { "title", "author", "year" },
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("bibtex")
require("telescope").load_extension("vimwiki")

-- Telescope
u.telescope_nmap("<leader>p", "fd")
u.telescope_nmap("<leader>b", "buffers")
u.telescope_nmap("<leader>B", "bibtex")
u.telescope_nmap("<leader>l", "current_buffer_fuzzy_find")
u.telescope_nmap("<leader>m", "marks")
u.telescope_nmap("<leader>M", "man_pages")
u.telescope_nmap("<leader>?", "oldfiles")
u.telescope_nmap("<leader>r", "live_grep")
u.telescope_nmap("<leader>gc", "git_bcommits")
u.telescope_nmap("<leader>gf", "git_files")
u.telescope_nmap("<leader>z", "spell_suggest")
u.telescope_nmap("<leader>d", "diagnostics bufnr=0")
u.telescope_nmap("<leader>D", "diagnostics")
u.telescope_nmap("<leader>t", "lsp_document_symbols")
u.telescope_nmap("<leader>T", "lsp_workspace_symbols")
u.telescope_nmap("gr", "lsp_references")
u.telescope_nmap("<leader>wl", "vimwiki link")
u.telescope_nmap("<leader>R", "vimwiki live_grep")
u.telescope_nmap("<leader>W", "find_files cwd=" .. os.getenv("WIKI"))
u.telescope_nmap("<leader>O", "find_files cwd=" .. os.getenv("ORGMODE"))
u.telescope_nmap("<leader>Z", "find_files cwd=" .. os.getenv("ZK"))
u.telescope_nmap("<leader>C", "find_files cwd=" .. os.getenv("XDG_CONFIG_HOME"))
u.telescope_nmap("<leader>N", "find_files cwd=" .. os.getenv("XDG_CONFIG_HOME") .. "nvim")
u.nmap("<leader>y", ':lua require("telescope").extensions.neoclip.default()<CR>')
