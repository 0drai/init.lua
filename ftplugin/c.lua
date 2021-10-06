local opt = vim.opt_local

opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2

-- Use `//` for comments instead of `/* ... */`
opt.commentstring = "// %s"

vim.cmd([[nnoremap <localleader>cc :ClangdSwitchSourceHeader<CR>]])
