local o = vim.opt_local

o.shiftwidth = 2
o.softtabstop = 2
o.tabstop = 2

-- Use `//` for comments instead of `/* ... */`
o.commentstring = "// %s"

vim.cmd([[nnoremap <localleader>cc :ClangdSwitchSourceHeader<CR>]])
