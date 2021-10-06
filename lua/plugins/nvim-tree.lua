local g = vim.g

g.nvim_tree_width = 35
g.nvim_tree_follow = 1
g.nvim_tree_auto_close = 1
g.nvim_tree_hijack_netrw = 1
g.nvim_tree_disable_netrw = 1
g.nvim_tree_quit_on_open = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_tab_open = 1
g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
g.nvim_tree_icons = {
	git = {
		unstaged = "✚",
		staged = "✚",
		unmerged = "≠",
		renamed = "≫",
		untracked = "★",
	},
}
