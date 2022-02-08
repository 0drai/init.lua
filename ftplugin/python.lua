local u = require("config.utils")
local o = vim.opt_local

o.expandtab = true
o.shiftwidth = 4
o.softtabstop = 4
o.tabstop = 8

o.textwidth = 0

-- quick pdb
u.nmap("<F1>", "iimport ipdb; ipdb.set_trace()<ESC>")
