local opt = vim.opt_local
local g = vim.g

opt.textwidth = 0
opt.shiftwidth = 2
opt.tabstop = 2

g.vimtex_quickfix_mode = "0"
g.vimtex_view_general_viewer = "okular"
g.vimtex_view_general_options_latexmk = "--unique"
g.tex_flavor = "latex"

vim.cmd([[
augroup latex_clean
  " runs 'latexmk -c' after quitting
  autocmd!
  au User VimtexEventQuit VimtexClean
augroup END
]])

vim.cmd([[set spelllang=en_us]])
