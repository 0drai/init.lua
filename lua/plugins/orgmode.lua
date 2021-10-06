-- NOTE: watch for treesitter support:
-- https://github.com/kristijanhusak/orgmode.nvim/issues/31

local org_path = os.getenv("ORGMODE")
local notes_file = org_path .. "notes.org"
local todo_file = org_path .. "todos.org"

require("orgmode").setup({
	org_agenda_files = { org_path .. "**/*" },
	org_default_notes_file = notes_file,
	org_agenda_templates = {
		a = {
			description = "TODO (default)",
			template = "\n* TODO [#A]\n %t\n %?",
			target = todo_file,
		},
		w = {
			description = "TODO (work)",
			template = "\n* TODO [#A] %t :WHK:\n %?",
			target = todo_file,
		},
		t = {
			description = "TODO (thesis)",
			template = "\n* TODO [#A] %t :WAT:\n %?",
			target = todo_file,
		},
		A = {
			description = "Notes (default)",
			template = "\n* %t \n%?",
			target = notes_file,
		},
		W = {
			description = "Notes (work)",
			template = "\n* %t :WHK:\n%?",
			target = notes_file,
		},
		T = {
			description = "Notes (thesis)",
			template = "\n* %t :WAT:\n%?",
			target = notes_file,
		},
	},
})
