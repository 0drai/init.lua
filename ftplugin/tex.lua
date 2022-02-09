local o = vim.opt_local
local g = vim.g
local c = vim.cmd

o.textwidth = 0
o.shiftwidth = 2
o.tabstop = 2

-- g.vimtex_quickfix_mode = "0"
-- g.vimtex_view_method = 'okular'
-- g.vimtex_view_forward_search_on_start = 1
-- g.tex_flavor = "latex"
-- g.conceallevel = 2

-- c([[
-- augroup latex_clean
--   " runs 'latexmk -c' after quitting
--   autocmd!
--   au User VimtexEventQuit VimtexClean
-- augroup END
-- ]])

c([[set spell]])
c([[set spelllang=en_us]])
