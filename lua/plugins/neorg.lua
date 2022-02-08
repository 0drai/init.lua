local u = require("config.utils")
local neorg_path = os.getenv("NEORG")

require("neorg").setup({
	-- Select the modules we want to load
	load = {
		["core.defaults"] = {}, -- Load all the defaults
		["core.norg.concealer"] = {
			config = {
				icon_preset = "diamond",
			},
		}, -- Allows the use of icons
		["core.keybinds"] = {
			config = {
				default_keybinds = true,
			},
		},
		["core.norg.dirman"] = { -- Manage Neorg directories
			config = {
				workspaces = {
					main = neorg_path,
					notes = neorg_path .. "notes",
					todos = neorg_path .. "todos",
				},

				autochdir = true,
				autodetect = true,
			},
		},
		["core.integrations.telescope"] = {},
		["core.gtd.base"] = {
			config = {
				workspace = "todos",
			},
		},
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.norg.journal"] = {
			config = {
				journal_folder = neorg_path .. "journal",
				strategy = "flat",
			},
		},
		-- ["external.zettelkasten"] = {},
	},
})

u.command("GtdCapture", "Neorg gtd capture")
u.command("GtdView", "Neorg gtd views")
u.command("GtdJournal", "Neorg journal today")

u.nmap("<localleader>nc", ":GtdCapture<CR>")
u.nmap("<localleader>nv", ":GtdView<CR>")
u.nmap("<localleader>nj", ":GtdJournal<CR>")
