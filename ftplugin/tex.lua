local o = vim.opt_local
local g = vim.g
local c = vim.cmd

o.textwidth = 0
o.shiftwidth = 2
o.tabstop = 2

-- o.foldmethod='syntax'
o.foldlevel=1

c([[set spell]])
c([[set spelllang=en_us]])
