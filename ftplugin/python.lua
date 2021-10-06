local default = { noremap = true, silent = true }
local opt = vim.opt_local

opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 8

opt.textwidth = 0

-- quick pdb
vim.api.nvim_set_keymap("n", "<F1>", "iimport ipdb; ipdb.set_trace()<ESC>", default)
